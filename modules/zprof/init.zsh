#
# Defines zprof helper functions
#
# Authors:
#   roalcantara <rogerio.alcantara@gmail.com>
#

#
# Functions
#

z_prof() {
  shell=${1-$SHELL}
  ZPROF=true $shell -i -c exit
}

z() {
  if [[ "$1" = "prof" ]]; then # z prof
    puts -c 'z_prof'
    eval 'z_prof'
  elif  [[ "$1" = "timing" ]]; then # z timing
    # https://htr3n.github.io/2018/07/faster-zsh/
    puts -c "for i in \$(seq 1 5); do /usr/bin/time /usr/local/bin/zsh  -i -c exit; done"
    for i in $(seq 1 5); do /usr/bin/time /usr/local/bin/zsh  -i -c exit; done
  else
    eval 'not found'
  fi
}
