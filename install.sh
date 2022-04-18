#!/bin/bash

# Installation script called when loaded into a Codespace

# are we on a mac or GH codespace? bootstrap!
# if [ $(uname -s) = "Darwin" ]; then
#   echo "Not set up to work with MacOS yet"
#   exit 1
# fi

echo "Adding git aliases"
git config --global include.path "/workspaces/.codespaces/.persistedshare/dotfiles/git/.gitalias"

# Extra packages I find useful

sudo apt install -y \
  fd-find \
  ripgrep \
  neovim \
  stow

# fd (find replacement)
# https://github.com/sharkdp/fd
[ ! -d "~/.local/bin" ] && mkdir -p ~/.local/bin
ln -s $(which fdfind) ~/.local/bin/fd

# git-delta for pretty diffs
# https://dandavison.github.io/delta
wget https://github.com/dandavison/delta/releases/download/0.12.1/git-delta_0.12.1_amd64.deb
dpkg -i git-delta_0.12.1_amd64.deb
git config --global include.path "/workspaces/.codespaces/.persistedshare/dotfiles/git/.gitdelta"

# Add dotfiles
stow tmux
stow nvim
