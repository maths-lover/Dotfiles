#!/usr/bin/env bash

# Symlink user config also
DOTFILES_DIR=$(dirname "$0")

mkdir -pv "$DOTFILES_DIR/nvim/.config/"
pushd "$DOTFILES_DIR/nvim/.config/" || return
git clone https://github.com/AstroNvim/AstroNvim.git nvim
popd || exit

# Symlinking nvim setup
stow nvim

git clone https://github.com/maths-lover/AstroNvim_user.git
pushd "$DOTFILES_DIR/AstroNvim_user" || return
git switch -C master
git remote set-url mehalterUpstream https://code.mehalter.com/AstroNvim_user
git pull mehalterUpstream --rebase master
git switch maths-lover
git pull origin --rebase maths-lover
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

# Setting up prettier for formatting
npm install -g prettier
