#
# Customize FZF
#
# Authors:
#   Rogério R. Alcantara <rogerio.alcantara@gmail.com>
#

accio() {
  fd --type f --hidden --follow --exclude .git --no-ignore | fzf --height 40% --reverse --preview 'bat --style=numbers --color=always {} | head -500'
}
