# Provides aliases and functions to manage dev environments.
#
# Authors:
#   Rogério R. Alcântara <rogerio.alcantara@gmail.com>
#

#
# Variables
#
export DEBUG_ROOT='debug'
export SECRETS_PATH='./.secrets'

#
# Functions
#
_prompt() {
  local brand="$FG[green]>$FG[none]  $BG[green]$FG[black] DEV $FX[none]"
  echo -e "\n$brand $1\n"
}

_info() {
  if [[-n $GOOGLE_APPLICATION_CREDENTIALS ]]; then
    puts "\$GOOGLE_APPLICATION_CREDENTIALS" $GOOGLE_APPLICATION_CREDENTIALS
  fi
  if [[-n $GH_TOKEN ]]; then
    puts "\$GH_TOKEN" $GH_TOKEN
  fi
  if [[-n $DEBUG ]]; then
    puts "\$DEBUG" $DEBUG
  fi
  echo -e ""
}

_debug() {
  if [[ -n "$1" ]]; then
    export DEBUG="$DEBUG_ROOT:$1,-*:trace"
  fi
}

_use() {
  ENV=$1
  if [[ -s "$PWD/$SECRETS_PATH/GOOGLE_APPLICATION_CREDENTIALS_$ENV.json" ]]; then
    export GOOGLE_APPLICATION_CREDENTIALS="$PWD/$SECRETS_PATH/GOOGLE_APPLICATION_CREDENTIALS_$ENV.json"
  fi
  if [[ -s "$PWD/$SECRETS_PATH/.$ENV.env" ]]; then
    while read LINE; do export "$LINE"; done <"$PWD/$SECRETS_PATH/.$ENV.env"
  fi
  _prompt 'Now using..'
  _info
}

zenv() {
  if [[ "$1" = "use" ]]; then
    if [[ -n "$2" ]]; then
      if [[ "$2" = "prod" ]]; then
        _use 'production'
      elif [[ "$2" = "stag" ]]; then
        _use 'staging'
      else
        _prompt "environment not found: $FG[red]'$2'$FX[none]"
      fi
    else
      _prompt "environment is required!"
    fi
  elif [[ "$1" = "info" ]]; then
    _prompt 'Environment'
    _info
  elif [[ "$1" = "debug" ]]; then
    _debug $2
    _info
  else
    _prompt "command not found: $FG[red]'$1'$FX[none]"
  fi
}
