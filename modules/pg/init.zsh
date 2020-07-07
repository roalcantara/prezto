#
# Defines PostgreSQL aliases and functions.
#
# Authors:
#   roalcantara <rogerio.alcantara@gmail.com>
#

# Load dependencies.
pmodload 'helper'

# Return if requirements are not found.
if ! is-darwin; then
  return 1
fi

#
# Aliases
#

# https://gist.github.com/roalcantara/60931c610d0d820149af
# https://gist.github.com/roalcantara/11283051
# pg {start|stop|restart|reload|status}
alias pg="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log"
