#!/usr/bin/env bash

# Symlinking nvim setup
stow nvim

# Symlink user config also
DOTFILES_DIR=$(dirname "$0")
pushd "$DOTFILES_DIR/AstroNvim_user" || return
git remote add mehalterUpstream https://git.mehalter.com/mehalter/AstroNvim_user.git
git pull mehalterUpstream --rebase
git pull origin --rebase
git switch maths-lover
popd || exit
rm -rfv "$HOME/.config/nvim/lua/user"
ln -rsv "$DOTFILES_DIR/AstroNvim_user" "$DOTFILES_DIR/nvim/.config/nvim/lua/user"

# Give instructions
printf "#####################################\n"
printf "#                                   #\n"
printf "#   Execute the following command   #\n"
printf "#                                   #\n"
printf "#####################################\n"
printf "\n"
printf "+--------------------------------------------------------------------------------+\n"
printf "|    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'    |\n"
printf "+--------------------------------------------------------------------------------+\n"


printf "You must merge the master branch from mehalter to maths-lover branch and update the config just in case\n"
