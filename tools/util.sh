LOG () {
  if [[ $1 == 'ERROR' ]]; then
    echo -e '[\u001b[31mERROR\u001b[0m]' [`date +"%F %T"`] $2
  else
    echo -e [$1] [`date +"%F %T"`] $2
  fi
}

INSTALL() {
  PKMGR=$1
}

set_env() {
  declare -A osInfo;
  osInfo[/etc/redhat-release]=yum
  osInfo[/etc/debian_version]=apt-get

  for f in ${!osInfo[@]}
  do
    if [[ -f $f ]]; then
      echo ${osInfo[$f]}
      return 0
    fi
  done
  return 1
}
