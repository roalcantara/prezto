#
# Defines Ruby on Rails aliases.
#
# Authors:
#   Robby Russell <robby@planetargon.com>
#   Jake Bell <jake.b.bell@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load dependencies.
pmodload 'ruby'

# Return if requirements are not found.
if (( ! $+commands[bundle] )); then
  return 1
fi

#
# Aliases
#

alias be='bundle exec'
alias r='be rails'
alias rc='r console'
alias rdc='r dbconsole'
alias rdbM='r db:migrate'
alias rordM='r db:migrate db:test:clone'
alias rordr='r db:rollback'
alias rg='r generate'
alias rl='tail -f "$(ruby-app-root)/log/development.log"'
alias rlc='be rake log:clear'
alias rorp='r plugin'
alias rorr='r runner'
alias rs='r server'
alias rsd='r server --debugger'
alias rd='r destroy'
alias rspec='be rspec'
