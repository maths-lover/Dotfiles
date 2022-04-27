#!/usr/bin/env bash

# Update your system as fresh boi
sudo dnf update --refresh -y

# Enable dnf copr repo for neovim
sudo dnf copr enable agriffis/neovim-nightly

# Install packages from fedora repos and rpmfusion repos
sed '{/^#/d};{/^$/d;}' packages.txt | xargs sudo dnf install -y

# Enable flathub repo also to install other applications
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Installing flatpak applications for flathub
flatpak install flathub org.telegram.desktop
flatpak install flathub com.slack.Slack
flatpak install flathub com.github.alexhuntley.Plots
flatpak install flathub com.discordapp.Discord
flatpak install flathub us.zoom.Zoom
flatpak install flathub com.microsoft.Teams
flatpak install flathub com.obsproject.Studio
flatpak install flathub de.haeckerfelix.Fragments

# ADB Setup for my device
echo "+-----------------------------------------------------------+"
echo "|             Connect your Phone to the system              |"
echo "+-----------------------------------------------------------+"
read -rp "Did you insert the device? (y/N): " response
if [[ "$response" == "y" || "$response" == "Y" ]]; then
	ANDROID_ID=$(lsusb | grep Xiaomi | cut -d' ' -f6 | cut -d':' -f1)
	echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"$ANDROID_ID\", MODE=\"0666\", GROUP=\"plugdev\"" | sudo tee -a /etc/udev/rules.d/51-android.rules
	sudo chmod a+r /etc/udev/rules.d/51-android.rules
	sudo udevadm control --reload-rules
fi

# Changing default shell to fish
chsh -s /bin/fish

# Installing extra packages
get_latest_release() {
	curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
		grep '"tag_name":' |                                             # Get tag line
		sed -E 's/.*"([^"]+)".*/\1/'                                     # Pluck JSON value
}
# 1. Neovide
mkdir -pv "$HOME/bin"
pushd "$HOME/bin" || return
wget "https://github.com/neovide/neovide/releases/download/0.8.0/neovide-linux.tar.gz.zip"
unzip neovide-linux.tar.gz.zip
tar -xf neovide-linux.tar.gz
mv target/release/neovide ./
rm -rf neovide-linux.tar.gz target
chmod u+x ./neovide

# 2. stylua
wget "https://github.com/JohnnyMorganz/StyLua/releases/download/v0.13.1/stylua-linux.zip"
unzip stylua-linux.zip
rm stylua-linux.zip -f
chmod u+x ./stylua
popd || return

# 3. cue_fmt
go install cuelang.org/go/cmd/cue@latest

# golangci_lint
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.45.2

exit
