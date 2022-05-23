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
else
	echo "Proceeding without adding your device to 51-android.rules in udev rules..."
fi

# Changing default shell to fish
chsh -s /bin/fish

# 1. cue_fmt
go install -v cuelang.org/go/cmd/cue@latest

# 2. golangci_lint
go install -v github.com/golangci/golangci-lint/cmd/golangci-lint@v1.45.2

# 3. Go debugger delve (dlv is executable)
go install -v github.com/go-delve/delve/cmd/dlv@latest

# 4. godoc the awesome doc for Go packages
go install -v golang.org/x/tools/cmd/godoc@latest

# 5. Setting up rust environment
if [[ ! -d "$HOME/.cargo/bin" ]]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# 6. Neovide
mkdir -pv "$HOME/dev/rust"
pushd "$HOME/dev/rust" || echo "Couldn't cd into $HOME/dev/rust" || return 1
git clone "https://github.com/neovide/neovide"
pushd neovide || echo "Couldn't cd into neovide" || return 1
~/.cargo/bin/cargo build --release
mkdir -pv "$HOME/bin"
cp "./target/release/neovide" "$HOME/bin/" -v
popd || printf "Exiting right after installing neovide\n" || return 1
popd || printf "Exiting right after installing neovide\n" || return 1

# 7. stylua
~/.cargo/bin/cargo install stylua || printf "Couldn't install stylua" || return 1

# 8. GLava visualizer
stow glava

# 9. Configure npm to use home local bin and not root
npm config set prefix "$HOME/.local/"

echo "Packages installation finished" || return 0
