# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

alias vlc='Applications/VLC.app/Contents/MacOS/VLC'
alias hate_coffeeshops='sudo tcpkill -i en1 -9 tcp portrange 6881-6999'

alias git=hub

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="greggroth"

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
plugins=(git brew greggroth osx extract tmux)

zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

source $ZSH/oh-my-zsh.sh

# Pretty diff
alias pdiff='colordiff -u'

#Tmuxinator
EDITOR='vim'
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

#Homewbrew
PATH=/usr/local/bin:$PATH
PATH=$PATH:/usr/local/sbin
PATH=$PATH:$HOME/bin

#Postgres.app
PATH="$PATH:/Applications/Postgres.app/Contents/MacOS/bin"

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

PLATFORM="mac"
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'

export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

export GOPATH=~/code/gocode
export PGHOST=localhost

# Remove anoying regex matching
unsetopt NOMATCH
