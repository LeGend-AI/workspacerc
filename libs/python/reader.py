import multiprocessing
from threading import Thread
import numpy as np
import itertools
import gzip
import os
import time
import math
import copy
try:
    import queue
except ImportError:
    import Queue as queue
import logging

class ParallelFileReader:
    def __init__(self, files, parse,
                 n_reader=8, n_merge=1,
                 batch_size=1024,
                 buffer_size=10240*4*2,
                 gzip=True, infinite=False):
        assert type(files) in [list, tuple]

        self.batch_size = batch_size
        self.n_reader = min(n_reader, len(files))
        self.files = files
        self.reader_processes = []
        self.reader_queues = []

        self.n_merge = n_merge
        self.merge_threads = []
        self.running_merge_threads = multiprocessing.Value('i')
        #self.merge_queue = queue.Queue(math.ceil(buffer_size / 256))
        self.merge_queue = queue.Queue(20)

        self.gzip = gzip
        self.parse = parse
        self._stop = multiprocessing.Value('b', True)
        self.infinite = infinite

        loghandler = logging.FileHandler('reader.log')
        loghandler.setLevel(logging.DEBUG)
        LOG_FORMAT = logging.Formatter("%(asctime)s: %(module)s:%(funcName)s: %(lineno)d %(levelname)s %(message)s")
        loghandler.setFormatter(LOG_FORMAT)
        self.logger = logging.getLogger(__name__ + str(id(self)))
        self.logger.setLevel(logging.DEBUG)
        self.logger.handlers = [loghandler]

    def _merge(self, idx, queues):
        running = len(queues)
        self.logger.debug("merge thread-{} start with {} queues".format(idx, running))
        for queue in itertools.cycle(queues):
            try:
                data = queue.get(False)
                if data == None:
                    running -= 1
                    if running <= 0:
                        with self.running_merge_threads.get_lock():
                            self.running_merge_threads.value -= 1
                        if self.running_merge_threads.value <= 0:
                            self._stop.value = True
                        break
                    continue
                self.merge_queue.put(data)
                self.logger.debug("merge data, queue size {}".format(self.merge_queue.qsize()))
            except:
                pass
        self.logger.debug("merge thread-{} stop".format(idx))

    def _reader(self, generator, idx):
        sources = generator.files[idx::generator.n_reader]
        batch_size = generator.batch_size
        if generator.infinite:
            sources = itertools.cycle(sources)
        open_instance = gzip.open if generator.gzip else open
        mode = 'rb' if generator.gzip else 'r'
        results = []
        for src in sources:
            with open_instance(src, mode) as f:
                generator.logger.debug("reader-{} open source {}".format(idx, src))
                for line in f:
                    if generator._stop.value:
                        generator.logger.debug("reader-{} stop".format(idx))
                        generator.reader_queues[idx].put(None)
                        return
                    datas = generator.parse(line.decode())
                    if datas is None:
                        continue
                    for data in datas:
                        for i in range(len(data)):
                            if i >= len(results):
                                results.append([])
                            results[i].append(data[i])
                    if len(results[0]) < batch_size:
                        continue
                    generator.reader_queues[idx].put([np.array(_[:batch_size]) for _ in results])
                    results = [_[batch_size:] for _ in results]
                    generator.logger.debug("reader-{} put data, queue size {}".format(idx, generator.reader_queues[idx].qsize()))
        generator.reader_queues[idx].put(None)
        generator.logger.debug("reader-{} stop".format(idx))

    def start(self):
        if not self._stop.value:
            return
        self._stop.value = False
        for i in range(self.n_reader):
            queue = multiprocessing.Queue(4)
            self.reader_queues.append(queue)
            process = multiprocessing.Process(target=self._reader, args=(self, i))
            process.start()
            self.reader_processes.append(process)

        self.running_merge_threads.value = 0
        for i in range(self.n_merge):
            thread = Thread(target=self._merge, args=(i, self.reader_queues[i::self.n_merge]))
            self.running_merge_threads.value += 1
            self.merge_threads.append(thread)
        for _ in self.merge_threads:
            _.start()

    def stop(self):
        self._stop.value = True
        for reader, queue in zip(self.reader_processes, self.reader_queues):
            try:
                while not queue.empty():
                    queue.get(False)
            except:
                pass
            reader.join()
        self.reader_processes.clear()
        self.reader_queues.clear()
        while self.running_merge_threads.value > 0:
            try:
                while not self.merge_queue.empty():
                    self.merge_queue.get(False)
            except:
                pass
        for _ in self.merge_threads:
            _.join()
        self.merge_threads.clear()

    def __call__(self):
        return self

    def next(self):
        return self.__next__()

    def __next__(self):
        if self._stop.value:
            raise StopIteration()
        data = self.merge_queue.get()
        return data

    def __iter__(self):
        return self
