#!/usr/bin/env bash
if [[ ! -f hardware-configuration.nix ]]; then
    nixos-generate-config --show-hardware-config > hardware-configuration.nix
fi

sudo nixos-rebuild switch --upgrade -I nixos-config=.