#
# Initializes Flutter.
#
# Authors:
#   Rogério R. Alcântara <rogerio.alcantara@gmail.com>
#

# Return if requirements are not found.
if [[ -s "$HOME/Documents/flutter" ]]; then
  path=("$HOME/Documents/flutter/bin" $path)
fi
