#
# Defines dotfiles aliases and functions.
#
# Authors:
#   roalcantara <rogerio.alcantara@gmail.com>
#

#
# Aliases
#
export DOTFILES_PATH="${ZDOTDIR:-$HOME}/.dotfiles"

#
# Functions
#
dot() {
  if [[ $PWD != $DOTFILES_PATH ]]; then
    cd $DOTFILES_PATH
  fi
}
