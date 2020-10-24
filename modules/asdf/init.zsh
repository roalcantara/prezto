#
# Setup asdf
#
# Authors:
#   Rogério R. Alcantara <rogerio.alcantara@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[asdf] && ! $+commands[asdf] )); then
  return 1
fi

#
# Variables
#
#
export ASDF_HOME='~/.asdf'

#
# Settings
#
#

if [[ -s "$PWD/.tool-versions" ]]; then
  PATH="$PATH:$ASDF_HOME"
  source "$(brew --prefix asdf)/asdf.sh" # just load the asdf wrapper function
fi

#
# Functions
#
#

# Return if requirements are not found.
if (( ! $+commands[direnv] && ! $+commands[direnv] )); then
  return 1
fi

# direnv
# https://github.com/asdf-community/asdf-direnv
#
if [[ -s "$PWD/.envrc" ]]; then
  eval "$(direnv hook zsh)"

  # A shortcut for asdf managed direnv.
  direnv() {
    asdf exec direnv "$@";
  }
fi
