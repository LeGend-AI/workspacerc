main() {
  if [ -d ${HOME}/.vim ]; then
    rm -rf ${HOME}/.vim
  fi
  if [ -f ${HOME}/.vimrc ]; then
    rm ${HOME}/.vimrc
  fi
  ln -s ${WORK_HOME}/vim/.vim ${HOME}
  ln -s ${WORK_HOME}/vim/.vimrc ${HOME}
}

main
