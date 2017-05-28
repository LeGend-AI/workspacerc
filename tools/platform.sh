INSTALL() {
  echo $passwd | sudo $PKMGR install -y -q $*
}

apple() {
  if type brew >/dev/null 2>/dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  echo $passwd | sudo brew update
  export PKMGR='brew'
}

redhat() {
  echo $passwd | sudo yum makecache
  export PKMGR='yum'
}

debian() {
  echo $passwd | sudo apt-get update
  export PKMGR='apt-get'
}


platform_check() {
  read -s -p "Enter your password: " passwd
  export passwd=$passwd
  if [[ $(uname) == 'Darwin' ]]; then
    apple
  elif [[ -f /etc/redhat-release ]]; then
    redhat
  elif [[ -f /etc/debian_version ]]; then
    debian
  else
    return 1
  fi
  return 0
}
