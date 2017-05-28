apple() {
  if type brew >/dev/null 2>/dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  brew update
  echo "brew"
}

redhat() {
  yum makecache
  echo "yum"
}

debian() {
  apt-get update
  echo "apt-get"
}

platform_check() {
  if [[ $(uname) == 'Darwin' ]]; then
    apple
  elif [[ -f /etc/redhat-release ]]; then
    redhat
  elif [[ -f /etc/debian_version ]]; then
    debian
  fi
}
