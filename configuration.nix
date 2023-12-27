{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos";
  # networking.wireless.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;  
    displayManager.gdm = {
      enable = true;  
      wayland = true; 
    };
    desktopManager.gnome.enable = true; 
  };

  # Excluding pre-installed packages in gnome
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-text-editor
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    gnome-weather
    gnome-contacts
    gnome-maps
    simple-scan
    gedit
    epiphany
    geary
    evince
    totem
    tali
    iagno
    hitori
    atomix
  ]);

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Exclude xterm
  services.xserver.excludePackages = [ 
    pkgs.xterm 
  ];
  

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.naman = {
    isNormalUser = true;
    description = "naman";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      htop
      google-chrome
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    distrobox
    git
    gnomeExtensions.pop-shell
    gnupg
    neofetch
    nur.repos.nltch.spotify-adblock
    vscode
    vim
    wget
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
  ];

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

  # Enable the OpenSSH daemon.
  # services = {
  #   openssh.enable = true;
  #   qemuGuest.enable = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.stateVersion = "23.11";

}
