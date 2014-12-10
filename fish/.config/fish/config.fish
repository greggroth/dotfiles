# Git Aliases
alias g "git"
alias git "hub"

# Tmux Aliases
alias ta "tmux attach -t"
alias ts "tmux new-session -s"
alias tl "tmux list-sessions"

# Open finder
alias f "open ."

# Ruby Aliases
alias be "bundle exec"

# Vim
alias vim "mvim -v"

set EDITOR vim

# Homewbrew
set PATH /usr/local/bin $PATH
set PATH $PATH /usr/local/sbin

# Julia
set PATH $PATH /Applications/Julia-0.3.0.app/Contents/Resources/julia/bin

# Scripts
set PATH $PATH $HOME/bin

# Postgres.app
set PATH $PATH /Applications/Postgres.app/Contents/Versions/9.3/bin
set PGHOST localhost

# Chruby
source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish

# Autojump
source /usr/local/Cellar/autojump/HEAD/etc/autojump.fish

# GoLang
set GOPATH ~/code/gocode

