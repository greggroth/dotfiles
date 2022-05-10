#!/bin/bash

export GITHUB_USERNAME=greggroth

sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply $GITHUB_USERNAME

echo "Adding git aliases"
git config --global --add include.path "/workspaces/.codespaces/.persistedshare/dotfiles/git/.gitalias"

# git-delta for pretty diffs
# https://dandavison.github.io/delta
if ! command -v delta &> /dev/null; then
  echo "Installing Git-Delta"
  wget https://github.com/dandavison/delta/releases/download/0.12.1/git-delta_0.12.1_amd64.deb
  sudo dpkg -i git-delta_0.12.1_amd64.deb
  rm git-delta_0.12.1_amd64.deb
  git config --global --add include.path "/workspaces/.codespaces/.persistedshare/dotfiles/git/.gitdelta"
fi

# Bash Setup
echo "Adding Bash dotfiles"
rm $HOME/.bashrc && stow bash -t $HOME
