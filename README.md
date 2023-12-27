# dotfiles

My current nixos dotfiles.

## Build process

```
cd /etc/nixos
sudo mv configuration.nix configuration.nix.backup
sudo wget https://raw.githubusercontent.com/Naman1997/nixos-config/main/configuration.nix
sudo nixos-rebuild switch --upgrade
sudo nix-collect-garbage --delete-old # Only if cleanup is needed
```
