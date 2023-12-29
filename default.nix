{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ./networking.nix
      ./sound.nix
      ./gnome.nix
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’
  users.users.naman = {
    isNormalUser = true;
    description = "naman";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      firefox
      gnomeExtensions.pop-shell
      gnupg
      htop
      neofetch
      nur.repos.nltch.spotify-adblock
      vscode
      zsh-autosuggestions
      zsh-history-substring-search
      zsh-syntax-highlighting
    ];
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  # Docker config
  virtualisation.docker.enable = true;

  # Zsh config
  programs.zsh = {
    enable = true;
    enableGlobalCompInit = false;
    histSize = 10000;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "docker" "kubectl" "zsh-autosuggestions" "zsh-history-substring-search" "zsh-syntax-highlighting" ];
      theme = "jonathan";
    };
  };

  # gnupg config
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon
  services = {
    openssh.enable = true;
    qemuGuest.enable = true;
  };
  
  # Nix settings
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  documentation.nixos.enable = false;
  system.stateVersion = "23.11";
}