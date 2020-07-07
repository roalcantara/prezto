#
# Customize FZF
#
# Authors:
#   Rogério R. Alcantara <rogerio.alcantara@gmail.com>
#

export FZF_DEFAULT_OPTS='--extended'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# FZF
#
# fzf <ENTER>
# fzf --exact <ENTER>
# ALT+C   change directory
# CTRL+R  search history
# COMMAND [DIRECTORY/][FUZZY_PATTERN]**<TAB> triggers fzf finder

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source module files.
source "${0:h}/fzf-git.zsh"
source "${0:h}/fzf-accio.zsh"
source "${0:h}/fzf-kitty.zsh"

teste() {
  echo "hi there!"
}
bindkey '^T' teste

# join-lines() {
#   local item
#   while read item; do
#     echo -n "${(q)item} "
#   done
# }
# 
# fzf-gl-widget() {
#   local result=\$(gbvl | join-lines);
#   zle reset-prompt;
#   LBUFFER+=\$result
# }
# zle     -N   fzf-gl-widget
