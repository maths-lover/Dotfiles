#!/usr/bin/env bash

DOTFILES_DIR=$(dirname "$0")

if [[ ! -f $HOME/ran_0_script ]]; then

	# Make your dnf fast as F**k boi
	echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf
	echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf

	# Update your system as fresh boi
	sudo dnf update --refresh -y

	################################################
	#        BEGIN actual grub-btrfs setup         #
	################################################
	mkdir -pv "$HOME/dev/misc"

	# Just in case git is not installed install it
	sudo dnf install git -y

	# Grub-Btrfs Timeshift snapshot booting
	git clone https://github.com/Antynea/grub-btrfs "$HOME/dev/misc/grub-btrfs"
	cd "$HOME/dev/misc/grub-btrfs" || return 1

	# Configure it
	sed -i 's/^#GRUB_BTRFS_GRUB_DIRNAME/GRUB_BTRFS_GRUB_DIRNAME/g' config
	sed -i 's/^#GRUB_BTRFS_MKCONFIG=\/usr\/bin\/grub2-mkconfig/GRUB_BTRFS_MKCONFIG=\/usr\/sbin\/grub2-mkconfig/g' config
	sed -i 's/^#GRUB_BTRFS_SCRIPT/GRUB_BTRFS_SCRIPT/g' config

	sudo make install
	sudo grub2-mkconfig -o /boot/grub2/grub.cfg

	sudo dnf install timeshift

	echo "+----------------------------------------------------------------+"
	echo "|   Rebooting your system and you \"must\" run this script again   |"
	echo "+----------------------------------------------------------------+"
	touch "$HOME/ran_0_script"
	systemctl reboot
fi

sudo env SYSTEMD_EDITOR="cp $DOTFILES_DIR/grub-btrfs.path" systemctl edit --full grub-btrfs.path

# before enabling grub-btrfs.path must run timeshift atleast once
timeshift-launcher

sudo systemctl enable --now grub-btrfs.path
# Status of the service we just modified
systemctl status grub-btrfs.path
systemctl -t mount | grep run-timeshift-backup.mount
echo "Sleeping for 15 seconds to allow you look into the output"
rm "$HOME/ran_0_script"
sleep 15s

# Fastening Fedora a bit
# Stop NetworkManager-wait-online.service
systemctl disable NetworkManager-wait-online.service

exit
