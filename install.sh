#!/bin/bash

set -e # -e: exit on error

if [ ! "$(command -v chezmoi)" ]; then
  bin_dir="$HOME/.local/bin"
  chezmoi="$bin_dir/chezmoi"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsLS https://chezmoi.io/get)" -- -b "$bin_dir"
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- https://chezmoi.io/get)" -- -b "$bin_dir"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
else
  chezmoi=chezmoi
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
# exec: replace current process with chezmoi init
exec "$chezmoi" init --apply "--source=$script_dir"

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
