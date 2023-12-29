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
