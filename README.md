# dotfiles

My current nixos dotfiles.

## Installation

This repo uses the hardware config that will be generated in the current dir using the `nixos-generate-config --show-hardware-config` command. It will not use the configuration files in `/etc/nixos`.

To install just run:

```
git clone https://github.com/Naman1997/dotfiles.git
cd dotfiles
chmod +x upgrade.sh
./upgrade.sh
```

# Steps To Reproduce My System


- Clone this repo
- Change username and hostname in flake.nix
- Replace your hardware-configuration.nix with the one inside the workstation or laptop folders
- Run this command:

```
sudo nixos-rebuild switch --flake .#workstation
```

# Special Thanks

This repo is esentially a fork of [zaneyos](https://gitlab.com/Zaney/zaneyos) with some of my changes on top.
