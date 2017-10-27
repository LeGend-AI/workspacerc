main() {
  if [ ! -d ~/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
  fi
  if [ ! $LG_WORKSPACERC ]; then
    cat $WORK_HOME/zsh/.zshrc >> $HOME/.zshrc
    env zsh
  fi
}

main
