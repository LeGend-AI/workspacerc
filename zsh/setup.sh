main() {
  if [ ! -d ~/.oh-my-zsh ]; then
    ln -s $WORK_HOME/zsh/.oh-my-zsh $HOME
  fi
  if [ ! $LG_WORKSPACERC ]; then
    cat $WORK_HOME/zsh/.zshrc >> $HOME/.zshrc
    env zsh
  fi
}

main
