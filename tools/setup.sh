#!/bin/bash

main() {

  export WORK_HOME=${HOME}/.workspacerc
  if [ -d ${WORK_HOME} ]; then
    echo ${WORK_HOME}" already exists."
    exit 1
  fi

  if ! type git >/dev/null 2>/dev/null; then
    echo "git not installed..."
    exit 1
  fi
  git clone http://github.com/legend-ai/workspacerc ${WORK_HOME}
  cd ${WORK_HOME}/tools

  source util.sh
  source platform.sh

  LG_platform_check
  if [ $? != 0 ]; then
    LG_LOG ERROR "Platform Unknown!"
    exit 1
  fi

  LG_LOG INFO "git setup..."
  cd ../git && sh install.sh && cd ../tools

  LG_LOG INFO "zsh setup..."
  if ! type zsh >/dev/null 2>/dev/null; then
    LG_INSTALL zsh
  fi
  cd ../zsh && sh install.sh && cd ../tools

  LG_LOG INFO "vim setup..."
  if ! type vim >/dev/null 2>/dev/null; then
    LG_INSTALL vim
  fi
  cd ../vim && zsh install.sh && cd ../tools
}

main
