export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(git)
source $ZSH/oh-my-zsh.sh
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} %{$fg[green]%}%*%{$reset_color%} $(git_prompt_info)'

alias search_code='find . -name "*.h" -or -name "*.cuh" \
  -or -name "*.cpp" \
  -or -name "*.cu" \
  -or -name "*.cc" \
  -or -name "*.c" \
  -or -name "CMakeLists.txt" \
  -or -name "*.proto" \
  -or -name "*.prototxt" \
  -or -name "*.cmake" | xargs grep -i --color=auto'

export PATH=${PATH}:~/bin
export LG_WORKSPACERC=~/.workspacerc
