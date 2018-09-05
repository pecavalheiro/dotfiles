#!/usr/bin/env bash

ln -s $(pwd)/.vimrc $(eval echo ~$USER)/
ln -s $(pwd)/.vimrc.bundles $(eval echo ~$USER)/
ln -s $(pwd)/.gitconfig $(eval echo ~$USER)/
ln -s $(pwd)/.tmux.conf $(eval echo ~$USER)/
ln -s $(pwd)/.bash_aliases $(eval echo ~$USER)/
echo '[[ -s "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases" # Load the default .bash_aliases' >> ~/.bash_profile
source $(eval echo ~$USER)/.bash_profile
