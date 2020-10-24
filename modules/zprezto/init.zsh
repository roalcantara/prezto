#
# Defines Integrates Prezto. aliases and functions.
#
# Authors:
#   roalcantara <rogerio.alcantara@gmail.com>
#

#
# Aliases
#

export ZPREZTO_PATH="${ZDOTDIR:-$HOME}/.zprezto"

#
# Functions
#
zprezto() {
  if [[ $PWD != $ZPREZTO_PATH ]]; then
    cd $ZPREZTO_PATH
  fi

  if [[ "$1" = "pull" ]]; then
    git pull --rebase upstream master
  elif [[ "$1" = "sync" ]]; then
    git submodule update --init --recursive --remote
  elif [[ "$1" = "update" ]]; then
    zprezto 'pull'
    zprezto 'sync'
  fi
}
