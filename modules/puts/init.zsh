#!/usr/bin/env bash

#
# Defines puts helper
#
# Authors:
#   roalcantara <rogerio.alcantara@gmail.com>
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

#
# Functions
#

puts() {
  if [[ "$1" = "-c" ]]; then
    echo -e "   $FX[standout]$FX[bold]$FX[faint]$FG[103]❯ $2$FG[none]\n"
  elif  [[ "$1" = "-d" ]]; then
    echo -e "   $FX[standout]$FX[bold]$FX[faint]$FG[177]$2:$FG[none] $FX[standout]$FX[faint]$FG[103]$3$FG[none]$4"
  elif  [[ "$1" = "-lol" ]]; then
    echo -e $(eval puts $2 | eval 'npx cowsay' | eval 'npx lolcatjs')
  else
    echo -e "   $FX[standout]$FX[faint]$FG[103]$1$FG[none]$2"
  fi
}
