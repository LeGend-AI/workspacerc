LG_INSTALL() {
  echo $passwd | sudo $PKMGR install -y -q $*
}

LG_apple() {
  if type brew >/dev/null 2>/dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  echo $passwd | sudo brew update
  export PKMGR='brew'
}

LG_redhat() {
  echo $passwd | sudo yum makecache
  export PKMGR='yum'
}

LG_debian() {
  echo $passwd | sudo apt-get update
  export PKMGR='apt-get'
}


LG_platform_check() {
  read -s -p "Enter your password: " passwd
  export passwd=$passwd
  if [[ $(uname) == 'Darwin' ]]; then
    LG_apple
  elif [[ -f /etc/redhat-release ]]; then
    LG_redhat
  elif [[ -f /etc/debian_version ]]; then
    LG_debian
  else
    return 1
  fi
  return 0
}
