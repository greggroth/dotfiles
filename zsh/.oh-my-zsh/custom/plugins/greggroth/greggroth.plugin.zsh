# Shortcut to my code projects
c() { cd ~/code/$1; }
_c() { _files -W ~/code -/; }
compdef _c c

# Shortcut for opening finder
alias f='open .'

# Shortcut for VIM
alias v='vim'
alias vi='vim'

# Tmux Aliases
# alias ta='tmux attach-session -t'
# alias tlist='tmux list-sessions'
# alias tnew='tmux new-session -s'
# alias tkill='tmux kill-session -t'

# Some extra things for git
# alias ggraph='git log --date-order --graph --date=short --pretty="%Cred%h%Creset (%Cgreen%cr%Creset): %s (%Cblue%an%Creset)" -10 | column -tx -s \:'
# compdef _git ggraph=git-log

# Copy with progress indicator
cpi() {
  if [ -z $2 ]; then
    echo "Usage:  cpi [origin] [destination]"
    return
  fi
  rsync --progress $1 $2
}

# What's using a port
whats_using() {
  lsof -i:$1;
}

# list of ActiveRecord::Base files sorted by line count
alias ar_file_list='ack ActiveRecord::Base app/models -l | xargs wc -l | sort -r | head'

# Mount my desktop computer
# alias mount_home='mount_smbfs //Greggory@greggory-pc/Users/Greggory/ ~/share'

# Open a file with VLC
vlc() { open $1 -a vlc; }

# Syntax-highlighted cat
ccat() { source-highlight -i $1 -o STDOUT -f esc256; }


alias be="bundle exec"
alias rspec="nocorrect rspec"
