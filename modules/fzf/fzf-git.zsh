# GIT ♡ FZF
# -------------

# CTRL-G, CTRL-F for files
# CTRL-G, CTRL-B for branches
# CTRL-G, CTRL-T for tags
# CTRL-G, CTRL-R for remotes
# CTRL-G, CTRL-H for commit hashes

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

fzf-preview() {
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview-window right:50% \
    --preview $@
}

glof() {
  is_in_git_repo || return 1

  glo |
    fzf-preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
    grep -o "[a-f0-9]\{7,\}" |
    tr -d '\n' |
    pbcopy
}

gbvf() {
  is_in_git_repo || return 1

  gbv |
    fzf-preview 'git log --oneline --graph --pretty="format:%C(bold green)%h%C(red)%d%C(reset) %s %C(yellow)(%cr)" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
    sed 's/^..//' |
    cut -d' ' -f1 |
    sed 's#^remotes/##' |
    tr -d '\n' |
    xargs git checkout
}

gbxf() {
  is_in_git_repo || return 1

  gbv |
    fzf-preview 'git log --oneline --graph --pretty="format:%C(bold green)%h%C(red)%d%C(reset) %s %C(yellow)(%cr)" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
    sed 's/^..//' |
    cut -d' ' -f1 |
    sed 's#^remotes/##' |
    tr -d '\n' |
    xargs git branch --delete
}

grf() {
  is_in_git_repo || return 1

  glo |
    fzf-preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
    grep -o "[a-f0-9]\{7,\}" |
    tr -d '\n' |
    xargs git rebase -i
}

gtf() {
  is_in_git_repo || return 1

  gt |
  fzf-preview 'git show --color=always {} | head -'$LINES
}

f() {
  if [[ "$1" = "glo" ]]; then
    glof
  elif [[ "$1" = "gbv" ]]; then
    gbvf
  elif [[ "$1" = "gbx" ]]; then
    gbxf
  elif [[ "$1" = "gt" ]]; then
    gtf
  else
    puts "command not found: $FG[red]'$1'$FX[none]"
  fi
}
