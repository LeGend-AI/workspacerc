main() {
  if [ ! -d ${HOME}/.oh-my-zsh ]; then
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  fi
  if ! type search_code >/dev/null 2>/dev/null; then
    echo "alias search_code='find . -name "*.h" -or -name "*.cuh" \
           -or -name "*.cpp" \
           -or -name "*.cu" \
           -or -name "*.cc" \
           -or -name "*.c" \
           -or -name "CMakeLists.txt" \
           -or -name "*.proto" \
           -or -name "*.prototxt" \
           -or -name "*.cmake" | xargs grep -i --color=auto'" >> ${HOME}/.zshrc
  fi
}

main
