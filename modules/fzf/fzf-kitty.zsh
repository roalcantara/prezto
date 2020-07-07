#
# Customize FZF
#
# Authors:
#   Rogério R. Alcantara <rogerio.alcantara@gmail.com>
#

export KITTY_HOME="$HOME/.config/kitty"
export KITTY_THEMES="$KITTY_HOME/kitty-themes/themes"
export COLOR_SCRIPTS_PATH="$HOME/Work/Shell/color-scripts/color-scripts"

kt() {
  if [[ "$1" == "theme" ]]; then
    if [[ "$2" == "pick" ]]; then
      kt 'theme' | pbcopy
      kt_set_theme `pbpaste`
    else
      fd . $KITTY_THEMES | fzf --height 40% --reverse --preview 'prettybat {} | head -500'
    fi
  fi
}

kt_color_test() {
  eval "$COLOR_SCRIPTS_PATH/colortest"
}

kt_colors() {
  grep -o '#.*' $1 | head -n 20 | tail -n 16
}

kt_hex() {
  even=($(eval "kt_colors $1" | sed -n 'n;p'))
  odd=($(eval "kt_colors $1" | sed -n 'p;n'))

  echo -e "\e[1;37m
  Black    Red      Green    Yellow   Blue     Magenta   Cyan    White
  ──────────────────────────────────────────────────────────────────────\e[0m"
  for i in {1..8}; do echo -en "\e[$((30+($i-1)))m ${odd[i]} \u2588\u2588 \e[0m"; done
  echo
  for i in {1..8}; do echo -en "\e[1;$((30+($i-1)))m ${even[i]} \u2588\u2588 \e[0m"; done
  echo -e "\n"
}

kt_set_theme() {
  kitty @ set-colors -a $1
  kt_preview $1
}

kt_preview() {
  filename=$(basename $1)
  echo -e "\n$(figlet -f digital $filename)"
  echo -e "$(kt_hex $1)\n"
  neofetch
}
