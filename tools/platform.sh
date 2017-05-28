LG_INSTALL() {
  if [ $PKMGR == "brew" ]]; then
    brew install -y -q $*
  else
    echo $passwd | sudo $PKMGR install -y -q $*
  fi
}

LG_apple() {
  if type brew >/dev/null 2>/dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  brew update
  export PKMGR='brew'
}

LG_redhat() {
  echo $passwd | sudo -S yum makecache
  export PKMGR='yum'
}

LG_debian() {
  echo $passwd | sudo -S apt-get update
  export PKMGR='apt-get'
}


LG_platform_check() {
  if [ $(uname) == 'Darwin' ]; then
    LG_apple
    return 0
  fi

  echo -n "Enter your password: "
  read -s passwd
  export passwd=$passwd
  if [ -f /etc/redhat-release ]; then
    LG_redhat
  elif [ -f /etc/debian_version ]; then
    LG_debian
  else
    return 1
  fi
  return 0
}
