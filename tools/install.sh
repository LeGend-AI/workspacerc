main() {
  HOME=~
  WORK_HOME=~/.workspacerc

  # require git
  git clone https://github.com/legend-ai/workspacerc $WORK_HOME

  # require vim
  source $WORK_HOME/vim/setup.sh

  # require zsh
  source $WORK_HOME/zsh/setup.sh
}

main
