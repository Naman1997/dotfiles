{ config, pkgs, ... }:
{
  # networking.wireless.enable = true;

  # Enable networking
  networking = {
    hostName = "NixOS";
    networkmanager.enable = true;
  };

  # Open ports in the firewall
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
}
