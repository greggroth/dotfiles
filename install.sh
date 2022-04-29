#!/bin/bash

# Installation script called when loaded into a Codespace

# are we on a mac or GH codespace? bootstrap!
if [ $(uname -s) = "Darwin" ]; then
  echo "Not set up to work with MacOS yet"
  exit 1
fi

echo "Adding git aliases"
git config --global --add include.path "/workspaces/.codespaces/.persistedshare/dotfiles/git/.gitalias"

# Extra packages I find useful
sudo apt install -y \
  tmux \
  fd-find \
  ripgrep \
  fzf \
  stow

# fd (find replacement)
# https://github.com/sharkdp/fd
if ! command -v fd &> /dev/null; then
  [ ! -d "$HOME/.local/bin" ] && mkdir -p $HOME/.local/bin
  ln -s $(which fdfind) $HOME/.local/bin/fd
fi

# git-delta for pretty diffs
# https://dandavison.github.io/delta
if ! command -v delta &> /dev/null; then
  echo "Installing Git-Delta"
  wget https://github.com/dandavison/delta/releases/download/0.12.1/git-delta_0.12.1_amd64.deb
  sudo dpkg -i git-delta_0.12.1_amd64.deb
  rm git-delta_0.12.1_amd64.deb
  git config --global --add include.path "/workspaces/.codespaces/.persistedshare/dotfiles/git/.gitdelta"
fi


# NeoVim Setup
echo "Adding NVIM dotfiles"
stow nvim -t $HOME

if ! command -v nvim  &> /dev/null; then
  echo "Installing NVIM"
  wget https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.deb
  sudo dpkg -i nvim-linux64.deb
  rm nvim-linux64.deb
  pip3 install neovim
  nvim --headless +PlugInstall +qa
  nvim --headless +UpdateRemotePlugins +qa
fi

# TMUX Setup
echo "Adding Tmux dotfiles"
stow tmux -t $HOME
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
$HOME/.tmux/plugins/tpm/bin/install_plugins

# Bash Setup
echo "Adding Bash dotfiles"
rm $HOME/.bashrc && stow bash -t $HOME
