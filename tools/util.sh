LG_LOG () {
  if [ $1 == 'ERROR' ]; then
    echo -e '[\u001b[31mERROR\u001b[0m]' [`date +"%F %T"`] $2
  else
    echo -e [$1] [`date +"%F %T"`] $2
  fi
}
