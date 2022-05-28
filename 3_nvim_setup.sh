#!/usr/bin/env bash

# Symlink user config also
DOTFILES_DIR=$(dirname "$0")

mkdir -pv "$DOTFILES_DIR/nvim/.config/"
pushd "$DOTFILES_DIR/nvim/.config/" || return
git clone https://github.com/AstroNvim/AstroNvim.git
popd || exit

# Symlinking nvim setup
stow nvim

git clone https://github.com/maths-lover/Astronvim_user.git
pushd "$DOTFILES_DIR/AstroNvim_user" || return
git remote add mehalterUpstream https://git.mehalter.com/mehalter/AstroNvim_user.git
git switch master
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
