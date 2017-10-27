main() {
  if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  fi
  if [ ! $LG_WORKSPACERC ]; then
    cat $WORK_HOME/zsh/.zshrc >> $HOME/.zshrc
    env zsh
  fi
}

main
