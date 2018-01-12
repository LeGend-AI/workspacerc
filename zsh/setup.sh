main() {
  if [ ! -d ~/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
  fi
  if [ ! $LG_WORKSPACERC ]; then
    if [ -f ${HOME}/.zshrc ]; then
      tail -n14 ${WORK_HOME}/zsh/.zshrc >> ${HOME}/.zshrc 
    else
      cat $WORK_HOME/zsh/.zshrc >> $HOME/.zshrc
    fi
    env zsh
  fi
}

main
