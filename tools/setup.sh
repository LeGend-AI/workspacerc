#!/bin/bash

. util.sh

main() {

  PKMGR=`env_detect`
  if [[ $? != 0 ]]; then
    LOG ERROR "Platform Unknown!"
    exit
  fi

  LOG INFO "Package Manager: "$PKMGR
  LOG INFO "Home dir: "$HOME

  LOG INFO "git setup..."

  LOG INFO "zsh setup..."
  if type zsh >/dev/null 2>/dev/null; then
    $PKMGR install zsh -y
  fi
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

  LOG INFO "vim setup..."
  cd ../vim && zsh install.sh && cd ../tools
}

main
