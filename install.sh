#!/bin/sh

# Installation script called when loaded into a Codespace

# are we on a mac or GH codespace? bootstrap!
# if [ $(uname -s) = "Darwin" ]; then
#   echo "Not set up to work with MacOS yet"
#   exit 1
# fi

echo "Adding git aliases"
git config --global include.path "/workspaces/.codespaces/.persistedshare/dotfiles/git/.gitalias"
