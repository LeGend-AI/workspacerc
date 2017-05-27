main() {
  if type vim >/dev/null 2>/dev/null; then
    $PKMGR install -y vim
  fi
  cp -r .vim* ~
}

main
