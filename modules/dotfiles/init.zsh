#
# Provides Dotfiles aliases and functions.
#
# Authors:
#   Rogério R. Alcântara <rogerio.alcantara@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[git] )); then
  return 1
fi

# Load dependencies.
pmodload 'helper'

# Source module files.
source "${0:h}/alias.zsh"

# Hide files that are not explicitly been tracked.
eval "$(dotfiles config --local status.showUntrackedFiles no)"
