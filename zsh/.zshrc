# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

alias git='hub'
gcoa () { git checkout `git rev-list -n 1 --before="$1" master` }

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="avit-gregg"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
# chruby
plugins=(git greggroth osx tmux zsh-syntax-highlighting zsh-history-substring-search docker-compose)

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

source $ZSH/oh-my-zsh.sh

#Tmuxinator
# alias vim='mvim -v'
alias vim='nvim'
export EDITOR=nvim
export NVIM_TUI_ENABLE_TRUE_COLOR=1
# [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

#Homewbrew
PATH=/usr/local/bin:$PATH
PATH=$PATH:/usr/local/sbin
PATH=$PATH:$HOME/bin
PATH=$PATH:/usr/local/opt/go/libexec/bin

#Postgres.app
PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
TZ="UTC"
PGTZ="UTC"

PLATFORM="mac"
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'

export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

export GOPATH=$HOME/code/gocode
export PGHOST=localhost

# Remove anoying regex matching
unsetopt NOMATCH

autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH=$PATH:$GOPATH/bin

export AMAZONREDSHIFTODBCINI=/opt/amazon/redshift/lib/universal/amazon.redshiftodbc.ini
# export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/lib

source /usr/local/share/zsh/site-functions/_aws
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# added by travis gem
[ -f /Users/greggory/.travis/travis.sh ] && source /Users/greggory/.travis/travis.sh


[ -f venv/bin/activate ] && source venv/bin/activate

_apex()  {
  COMPREPLY=()
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local opts="$(apex autocomplete -- ${COMP_WORDS[@]:1})"
  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}

complete -F _apex apex
export PATH="/usr/local/opt/qt5/bin:$PATH"
