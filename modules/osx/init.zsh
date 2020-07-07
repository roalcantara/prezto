#
# Defines macOS aliases and functions.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
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

# Changes directory to the current Finder directory.
alias cdf='cd "$(pfd)"'

# Pushes directory to the current Finder directory.
alias pushdf='pushd "$(pfd)"'

alias code='code-insiders'

# Make Alfred / Spotlight ignore node_modules and bower_components
# https://gist.github.com/runspired/b5552be57d3c8a5a7821
alias nom='rm -rf node_modules && mkdir node_modules && touch node_modules/.metadata_never_index && a=`npm get progress` && npm set progress=false && npm install && npm set progress=$a'
alias nom-cache='npm cache clean && nom'
alias large_files_top='du -a * | sort -r -n | head -30 | tail -10'
alias large_files='du -sh * | sort -r -n'
alias cache_status='AssetCacheManagerUtil status'
alias cache_clear='sudo AssetCacheManagerUtil flushCache && sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder && rm -rf ~/Library/Caches/*'

freeFormat() {
  local mb=$2
  if ((mb > 1024)); then
    local gb=$(echo "scale=2; $mb/1024" | bc -l)
    echo -e "$1: $(printf '%.2fGB', $gb)"
  else
    echo -e "$1: $(printf '%.0fMB', $mb)"
  fi
}

freeCalc() {
  local pages=$2
  local input=$((pages * 4096))
  local val=$(echo "scale=8; $input/1024" | bc -l)
  local mb=$(echo "scale=8; $val/1024" | bc -l)

  freeFormat $1 $mb
}

free() {
  STATS=$(memory_pressure && echo "Total: $(eval sysctl -n hw.memsize)")
  FREE=$(echo $STATS | grep "^Pages free:" | awk '{ print $3 }')
  ACTIVE=$(echo $STATS | grep "^Pages active:" | awk '{ print $3 }')
  INACTIVE=$(echo $STATS | grep "^Pages inactive:" | awk '{ print $3 }')
  WIRED=$(echo $STATS | grep "^Pages wired down:" | awk '{ print $4 }')
  TOTAL_BYTES=$(echo $STATS | grep "^Total:" | awk '{ print $2 }')
  TOTAL=$(echo "$(($TOTAL_BYTES / 1024 / 1024 / 1024))" | awk -F '.' '{ print $1"GB" }')

  freeCalc "WIRED" $WIRED
  freeCalc "ACTIVE" $ACTIVE
  freeCalc "INACTIVE" $INACTIVE
  freeCalc "FREE" $FREE
  echo -e "TOTAL: $TOTAL"
}
