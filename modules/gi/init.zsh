#
# Allow access the gitignore.io API
#
# Authors:
#   Rogério R. Alcantara <rogerio.alcantara@gmail.com>
#

# Add a function to the environment
function gi() {
  if [[ "$1" = "-a" ]]; then
    echo $2 >> .gitignore
    echo -e " $FX[standout]$FX[bold]$FX[faint]$FG[177]❯ echo $FG[none]$FX[standout]$FG[229]'$2'$FX[standout]$FX[bold]$FX[faint]$FG[177] >> .gitignore$FG[none] $FG[121]✔$FG[none]\n"
  else
    curl -sL https://www.gitignore.io/api/$1 >> .gitignore
  fi
}
