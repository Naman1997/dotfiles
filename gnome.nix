{ pkgs, ... }:
{
  # Enable the GNOME Desktop Environment
  services = {
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      displayManager.gdm = {
        enable = true;  
        wayland = true; 
      };
      desktopManager.gnome.enable = true; 
    };

    gnome = {
      gnome-browser-connector.enable = false;
      gnome-initial-setup.enable = false;
      gnome-online-accounts.enable = false;
    };
  };

  # Excluding pre-installed packages in gnome
  environment.gnome.excludePackages = with pkgs; [
    gnome-connections
    gnome-text-editor
    gnome-tour
    loupe
    snapshot
    gnome.epiphany
    gnome.evince
    gnome.geary
    gnome.gnome-backgrounds
    gnome.gnome-characters
    gnome.gnome-contacts
    gnome.gnome-font-viewer
    gnome.gnome-logs
    gnome.gnome-maps
    gnome.gnome-music
    gnome.gnome-themes-extra
    gnome.gnome-weather
    gnome.simple-scan
    gnome.sushi
    gnome.totem
    gnome.yelp
    orca
  ];
}