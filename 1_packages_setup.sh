#!/usr/bin/env bash

# Update your system as fresh boi
sudo dnf update --refresh -y

# Install packages from fedora repos and rpmfusion repos
sed '{/^#/d};{/^$/d;}' packages.txt | xargs sudo dnf install -y

# Enable flathub repo also to install other applications
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Installing flatpak applications for flathub
flatpak install flathub org.telegram.desktop
flatpak install flathub com.slack.Slack
flatpak install flathub com.github.alexhuntley.Plots
#flatpak install flathub com.discordapp.Discord
#flatpak install flathub us.zoom.Zoom
#flatpak install flathub com.microsoft.Teams
#flatpak install flathub com.obsproject.Studio
flatpak install flathub de.haeckerfelix.Fragments

# ADB Setup for my device
echo "+-----------------------------------------------------------+"
echo "|             Connect your Phone to the system"             |"
echo "+-----------------------------------------------------------+"
echo "Did you insert the device? (y/N): "
read response
if [[ response == "y" || response == "Y" ]]
then
	ANDROID_ID=$(lsusb | grep Xiaomi | cut -d' ' -f6 | cut -d':' -f1)
fi

echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"$ANDROID_ID\", MODE=\"0666\", GROUP=\"plugdev\"" | sudo tee -a /etc/udev/rules.d/51-android.rules
sudo chmod a+r /etc/udev/rules.d/51-android.rules
sudo udevadm control --reload-rules

# Changing default shell to fish
chsh -s /bin/fish
