env_detect() {
  declare -A osInfo;
  osInfo[/etc/redhat-release]=yum
  osInfo[/etc/debian_version]=apt-get

  for f in ${!osInfo[@]}
  do
    if [[ -f $f ]]; then
      export INSTALL_TOOL='${osInfo[$f]} install -y -q'
    fi
  done

  export MYHOME=$HOME
  export 
}

main() {

  env_detect
  echo "Package Manager: " $PKMGR

  ####################
  #    zsh setup     #
  ####################
  echo "zsh setting..."
  if type zsh >/dev/null 2>/dev/null; then
    $PKMGR install zsh -y
  fi
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  echo "after"

  ####################
  #    VIM setup     #
  ####################
  echo "vim setting..."
  cd vim && zsh install.sh && cd ..
}

main
