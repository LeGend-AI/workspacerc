
export PATH=~/bin:$PATH
alias search_code='find . -name "*.h" -or -name "*.cuh" \
  -or -name "*.cpp" \
  -or -name "*.cu" \
  -or -name "*.cc" \
  -or -name "*.c" \
  -or -name "CMakeLists.txt" \
  -or -name "*.proto" \
  -or -name "*.prototxt" \
  -or -name "*.cmake" | xargs grep -i --color=auto'
export LG_WORKSPACERC=LeGend-AI

