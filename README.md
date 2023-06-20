# nixos-config

My current nixos config.

## Build process [Only on NixOS]

```
cd /etc/nixos
sudo mv configuration.nix configuration.nix.backup
sudo wget -O test.nix https://raw.githubusercontent.com/Naman1997/nixos-config/main/configuration.nix
sudo nixos-rebuild switch
```
