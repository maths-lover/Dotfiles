#!/usr/bin/env bash

# Symlinking nvim setup
stow nvim

# Symlink user config also
DOTFILES_DIR=$(dirname $0)
ln -rsv $DOTFILES_DIR/nvim_user_files $HOME/.config/nvim/lua/user
