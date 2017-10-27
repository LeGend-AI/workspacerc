main() {
  HOME=~
  WORK_HOME=~/.workspacerc

  # require git
  git clone https://github.com/legend-ai/workspacerc $WORK_HOME

  # require vim
  . $WORK_HOME/vim/setup.sh

  # require zsh
  . $WORK_HOME/zsh/setup.sh
}

main
