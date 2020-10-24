#
# Neovim settings
#
# Authors:
#   Rogério R. Alcantara <rogerio.alcantara@gmail.com>
#

export BAT_THEME="Dracula"
export MYVIMRC=$HOME/.vimrc
export XDG_CONFIG_HOME=$HOME/.config
export NVIM=$XDG_CONFIG_HOME/nvim
export VIMRUNTIME=$VIM/runtime

if type nvim >/dev/null 2>&1; then
  alias vim='vi'
fi

zv() {
  if [[ -n "$1" ]]; then
    if [[ "$1" == "." ]]; then
      nvim $(fzf --height 80% --reverse --preview 'bat --style=numbers --color=always {} | head -500')
    else
      nvim $1
    fi
  else
    nvim
  fi
}
