#
# Setup custom environment variables
#
# Authors:
#   Rogério R. Alcantara <rogerio.alcantara@gmail.com>
#

if [[ -s "$HOME/.env" ]]; then
  export $(egrep -v '^#' $HOME/.env | xargs)
fi

if [[ -s $GPG_AUTH_USERNAME ]]; then
  git config --global user.name $GPG_AUTH_USERNAME
fi

if [[ -s $GPG_AUTH_EMAIL ]]; then
  git config --global user.email $GPG_AUTH_EMAIL
fi

if [[ -s $GPG_KEY_ID ]]; then
  git config --global user.signingkey $GPG_KEY_ID
fi
