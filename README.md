# Dotfiles 
My development environment dotfiles and configs

# Notes
Add the following options in your `/etc/fstab` to have better lifetime for your SSD
- `defaults,noatime,discard=async`
> Scripts work only on fedora
> Config files should work regardless of the distro you are using

## Procedure to install my dotfiles (Should work universally)
1. Clone the repo

```bash
git clone https://github.com/maths-lover/Dotfiles.git $HOME/Dotfiles
```

2. `cd` into Dotfiles

```bash
cd $HOME/Dotfiles
```

3. Run first initial setup script, do review it once

```bash
chmod u+x ./0_system_setup.sh
./0_system_setup.sh
```

4. Run second script which installs packages (assumes flatpak is installed)

```bash
chmod u+x ./1_packages_setup.sh
./1_packages_setup.sh
```
