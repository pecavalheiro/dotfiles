#!/usr/bin/env bash

mkdir -p $(eval echo ~$USER)/.config/nvim/lua/pedro

ln -s $(pwd)/.vimrc $(eval echo ~$USER)/
ln -s $(pwd)/lua/pedro/options.lua $(eval echo ~$USER)/.config/nvim/lua/pedro/
ln -s $(pwd)/lua/pedro/keymaps.lua $(eval echo ~$USER)/.config/nvim/lua/pedro/
ln -s $(pwd)/lua/pedro/plugins.lua $(eval echo ~$USER)/.config/nvim/lua/pedro/
ln -s $(pwd)/lua/pedro/legacy.vim $(eval echo ~$USER)/.config/nvim/lua/pedro/
ln -s $(pwd)/.gitconfig $(eval echo ~$USER)/
ln -s $(pwd)/.tmux.conf $(eval echo ~$USER)/
ln -s $(pwd)/.bash_aliases $(eval echo ~$USER)/

echo '[[ -s "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases" # Load the default .bash_aliases' >> ~/.zprofile
source $(eval echo ~$USER)/.zprofile
