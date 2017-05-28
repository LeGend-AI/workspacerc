main() {
  if [ -h ${HOME}/.gitingore ]; then
    rm ${HOME}/.gitingore
  fi
  if [ -f ${HOME}/.gitingore ]; then
    mv ${HOME}/.gitingore ${HOME}/.gitingore.bak
  fi
  ln -s ${WORK_HOME}/.gitingore ${HOME}/.gitingore
}

main
