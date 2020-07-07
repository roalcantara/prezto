#
# Defines Yarn aliases.
#
# Authors:
#   Rogério R. Alcântara <rogerio.alcantara@gmail.com>
#

#
# Aliases
#

alias y='yarn'
alias ya='yarn add'
alias yag='yarn global add'
alias yb='yarn build'
alias yl='yarn lint'
alias yt='yarn test'
alias ys='yarn start'
alias yc='yarn clear'

#
# Functions
#

y_echo_if() {
  if [[ -z "$1" ]] || [[ "$1" = "" ]]; then
    echo -e $2
  else
    echo -e $1
  fi
}

y_run() {
  puts -c $1
  if [[ ! -z "$1" ]]; then
    eval $1
  fi
}

y_run_each() {
  if [[ ! -z "$1" ]] && [[ -n $1 ]]; then
    while read -r line; do
      y_run $line
    done <<< $1
  fi
}

yr() {
  y_run 'rm -rf dist tmp coverage node_modules ./yarn.lock && yarn install'
}

yo() {
  if [[ "$1" = "compact" ]]; then
    eval "yo" | sed -n '/Package/,/Done/ p' | sed -e '$ d' | tail -n +2
  elif  [[ "$1" = "deps" ]]; then
    yod
  elif [[ "$1" = "deps:packages" ]]; then
    yod "packages"
  elif [[ "$1" = "deps:scopes" ]]; then
    yod "scopes"
  elif [[ "$1" = "cmd" ]]; then
    yoc
  elif [[ "$1" = "cmd:packages" ]]; then
    yoc "packages"
  elif [[ "$1" = "cmd:scopes" ]]; then
    yoc "scopes"
  elif [[ "$1" = "bump" ]]; then
    yob
  elif [[ "$1" = "bump:packages" ]]; then
    yob "packages"
  elif [[ "$1" = "bump:scopes" ]]; then
    yob "scopes"
  else
    eval 'yarn outdated --no-progress'
  fi
}

yo_deps() {
  if [[ "$1" = "all" ]] || [[ "$1" = "$2" ]]; then
    if [[ ! -z "$4" ]]; then
      local dependencies=$4
    else
      local dependencies=$(yo compact)
    fi

    if [[ ! -z "$dependencies" ]] && [[ -n $dependencies ]]; then
      echo -e $dependencies | awk $3 | uniq
    fi
  fi
}

yod() {
  local arg=$(y_echo_if "$1" 'all')

  yo_deps "$arg" 'packages' 'BEGIN { counter=0; }
    { split($1,a,"/"); scope[a[1]]++; name[counter]=a[1]; dependency[counter]=$1; version[counter]=$4; counter++; }
    END {
      for (i = 0; i <= counter; i++) {
        if (scope[name[i]] == 1) {
          print dependency[i],version[i];
        }
      }
    }
  ' $2
  yo_deps "$arg" 'scopes' 'BEGIN { counter=0; }
    { split($1,a,"/"); scope[a[1]]++; name[counter]=a[1]; version[counter]=$4; counter++; }
    END {
      for (i = 0; i <= counter; i++) {
        if (scope[name[i]] > 1) {
          print name[i],version[i];
        }
      }
    }
  ' $2
}

yoi() {
  local version=$(eval yarn info $1 --json | jq '.data.version' | tr -d '"')
  local name=$(eval yarn info $1 --json | jq '.data.name' | tr -d '"')
  local description=$(eval yarn info $1 --json | jq '.data.description' | tr -d '"')
  local repository=$(eval yarn info $1 --json | jq '.data.repository.url' | tr -d '"' | sed -e 's/git+//g' | sed -e 's/\.git//')
  local repo=$(echo $repository | sed -e 's/.*.com\/\(.*\)/\1/')
  local changelog="https://raw.githubusercontent.com/$repo/master/CHANGELOG.md"
  local releases="https://api.github.com/repos/$repo/releases"
  local -a arr=($version,$name,$description,$repository,$repo,$changelog,$releases)
  echo "${arr[@]}"
}

yo_info() {
  if [[ -n "$1" ]]; then
    local info=$(yoi $1)
    echo
    puts -d "version" "$(echo $info | awk -F, '{print $1}')"
    puts -d "name" "$(echo $info | awk -F, '{print $2}')"
    puts -d "description" "$(echo $info | awk -F, '{print $3}')"
    puts -d "repository" "$(echo $info | awk -F, '{print $4}')"
    puts -d "repo" "$(echo $info | awk -F, '{print $5}')"
    puts -d "changelogs" "$(echo $info | awk -F, '{print $6}')"
    puts -d "releases" "$(echo $info | awk -F, '{print $7}')" '\n'
  else
    local dependency=$(yo compact | fzf --height 10% --border --reverse | awk '{print $1}')
    yo_info $dependency
  fi
}

yo_build_commit() {
  local message=$(echo $1)
  message+="\n\nMore: $2"
  echo -e $message
}

yo_build_changelog_commit() {
  local body="Changelog:\n\n"
  local message="$(echo $1 | tr -d '"' | awk '{gsub(/.{70}/,"&\n")}1')"
  body+=$(yo_build_commit $message $2)
  echo -e $body
}

yo_changelog_from_readme() {
  local changelogs=$(curl -s $1)

  if [[ -n "$changelogs" ]]; then
    local query="/<a name=\"$2\"/{flag=1;next}/<a name=/{flag=0}flag"
    local result=$(echo -e $changelogs | awk $query | awk '{$1=$1};1')
    local message=${result%%+([[:space:]])}

    if [[ ! -z "$message" ]] && [[ -n "$message" ]] && [[ "$message" != "" ]]; then
      yo_build_changelog_commit $message $url
    fi
  fi
}

yo_changelog_from_github() {
  local query=".[] | select(.tag_name|test(\"$2\"))"
  local body=$(curl -s $1 | jq "$query | .body")

  if [[ -n "$body" ]] && [[ "$body" != "" ]]; then
    local url=$(curl -s $1 | jq "$query | .html_url" | tr -d '"')
    yo_build_changelog_commit $body $url
  fi
}

yo_changelog_from() {
  local changelog=$(yo_changelog_from_readme $1 $2)

  if [[ -z "$changelog" ]] || [[ "$changelog" = "" ]]; then
    changelog=$(yo_changelog_from_github $3 $2)
  fi

  if [[ -z "$changelog" ]] || [[ "$changelog" = "" ]]; then
    changelog=$(yo_build_commit $5 $4)
  fi

  echo -e $changelog
}

yo_changelog() {
  if [[ -n "$1" ]]; then
    local info=$(yoi $1)
    local version=$(echo $info | awk -F, '{print $1}')
    local description=$(echo $info | awk -F, '{print $3}')
    local repository=$(echo $info | awk -F, '{print $4}')
    local changelogs=$(echo $info | awk -F, '{print $6}')
    local releases=$(echo $info | awk -F, '{print $7}')
    local changelog=$(yo_changelog_from "$changelogs" "$version" "$releases" "$repository" "$description")
    echo $changelog
  else
    local package=$(yo compact | fzf --height 10% --border --reverse | awk '{print $1}')
    yo_changelog $package
  fi
}

yo_version() {
  local version=$2
  if [[ -z "$version" ]] && [[ ! -n $version ]]; then
    version=$(eval yarn info $1 --json | jq '.data.version' | tr -d '"')
  fi
  echo -e $version
}

yo_commit() {
  if [[ -n "$1" ]]; then
    local version=$(yo_version $1 $2)
    local changelog=$(yo_changelog $1)
    git commit --no-verify -am "chore(packages): Bump $1 to $version" -m "$changelog"
  else
    local package=$(yo compact | fzf --height 10% --border --reverse | awk '{print $1}')
    yo_commit $package
  fi
}

yo_commands() {
  if [[ -n "$1" ]]; then
    local version=$(yo_version $1 $2)
    eval "yarn upgrade "$1" --latest"
    yo_commit $1 $version
  else
    local package=$(yo compact | fzf --height 10% --border --reverse | awk '{print $1}')
    yo_commands $package
  fi
}

yoc() {
  local dependencies=$(yod $1 $2)

  if [[ ! -z "$dependencies" ]] && [[ -n $dependencies ]]; then
    while read -r line; do
      local dependency=$(echo $line | awk '{print $1}')
      local version=$(echo $line | awk '{print $2}')
      yo_commands $dependency $version
    done <<< $dependencies
  fi
}

yo_bump() {
  if [[ "$1" = "all" ]] || [[ "$1" = "$2" ]]; then
    yoc $2 $3
  fi
}

yob() {
  yo
  local arg=$(y_echo_if "$1" "all")
  local dependencies=$(yo compact)

  if [[ ! -z "$dependencies" ]]; then
    yo_bump $arg 'packages' $dependencies
    yo_bump $arg 'scopes' $dependencies
    yr
    y_run "git commit -a --amend --no-edit --no-verify"
    terminal-notifier -title '📦' -message 'Bumper has finished!' -sound default
  fi
}
