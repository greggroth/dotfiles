# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

alias git='hub'
alias t='todo.sh'
gcoa () { git checkout `git rev-list -n 1 --before="$1" master` }

alias news='newsboat'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="avit"

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
bindkey '^U' backward-kill-line

zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

#Tmuxinator
# alias vim='mvim -v'
alias vim='nvim'
# [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

PLATFORM="mac"
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'

# Remove anoying regex matching
unsetopt NOMATCH

autoload run-help
autoload bashcompinit
bashcompinit
HELPDIR=/usr/local/share/zsh/helpfiles

# source /usr/local/share/zsh/site-functions/_aws
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


[ -f venv/bin/activate ] && source venv/bin/activate

_apex()  {
  COMPREPLY=()
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local opts="$(apex autocomplete -- ${COMP_WORDS[@]:1})"
  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}

complete -F _apex apex


if [[ $TERM = dumb ]]; then
  unset zle_backeted_paste
fi
