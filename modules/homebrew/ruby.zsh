# Setup homebrew`s ruby
#
# Authors:
#   roalcantara <rogerio.alcantara@gmail.com>
#

#
# Settings
#

# By default, binaries installed by gem will be placed into:
#   /usr/local/lib/ruby/gems/2.7.0/bin
#
# To have ruby first in your PATH:
export PATH="/usr/local/opt/ruby/bin:$PATH"

# For compilers to find ruby you may need to set:
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"

# For pkg-config to find ruby you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
