#!/usr/bin/env bash

ln -s $(pwd)/.vimrc $(eval echo ~$USER)/
ln -s $(pwd)/.vimrc.bundles $(eval echo ~$USER)/
ln -s $(pwd)/.gitconfig $(eval echo ~$USER)/
ln -s $(pwd)/.tmux.conf $(eval echo ~$USER)/
ln -s $(pwd)/.bash_aliases $(eval echo ~$USER)/
ln -s $(pwd)/redshift.conf $(eval echo ~$USER)/.config/
source $(eval echo ~$USER)/.bashrc
