main() {
  if [ ! -d ${HOME}/.oh-my-zsh ]; then
    echo exit | sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  fi

  if [ ! -d ${HOME}/bin ]; then
    mkdir ${HOME}/bin
  fi

  if [ ! -f ${HOME}/bin/cpplint.py ]; then
    cp ${WORK_HOME}/zsh/cpplint.py ${HOME}/bin
  fi

  if [ "${LG_WORKSPACERC}" != "LeGend-AI" ]; then
    cat ${WORK_HOME}/zsh/.zshrc >> ${HOME}/.zshrc
    bash -c "source ${HOME}/.zshrc"
  fi
}

main
