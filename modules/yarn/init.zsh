#
# Provides Yarn aliases and functions.
#
# Authors:
#   Rogério R. Alcântara <rogerio.alcantara@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[yarn] )); then
  return 1
fi

# Source module files.
source "${0:h}/alias.zsh"
