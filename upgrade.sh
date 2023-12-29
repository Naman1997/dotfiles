#!/usr/bin/env bash
if [[ ! -f hardware-configuration.nix ]]; then
    nixos-generate-config --show-hardware-config > hardware-configuration.nix
fi

sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
sudo nix-channel --update
sudo nixos-rebuild switch -I nixos-config=.

if [[ ! -f ~/.zshrc ]]; then
    echo "source $ZSH/oh-my-zsh.sh \nneofetch --disable model resolution wm_theme wm theme icons packages uptime de shell term --ascii_distro Nixos_small --color_blocks off" > ~/.zshrc
fi