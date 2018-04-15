#
# Provides Dotfiles aliases and functions.
#
# Authors:
#   Rogério R. Alcântara <rogerio.alcantara@gmail.com>
#

#
# Aliases
#

if ! zstyle -t ':prezto:module:dotfiles:alias' skip 'yes'; then
  alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
fi
