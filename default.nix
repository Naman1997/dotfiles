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
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      feh
      firefox
      gh
      gnomeExtensions.pop-shell
      gnupg
      htop
      neofetch
      nur.repos.nltch.spotify-adblock
      vscode
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

  # Default shell
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh bashInteractive ];

  # gnupg config
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable other services
  services = {
    openssh.enable = true;
    qemuGuest.enable = true;
  };

  # Zsh config
  programs.zsh = {
    enable = true;
    histSize = 10000;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "docker" "kubectl" ];
      theme = "jonathan";
    };
  };
  
  # Nix settings
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  documentation.nixos.enable = false;
  system.stateVersion = "23.11";
}