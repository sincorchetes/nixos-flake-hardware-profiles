{ lib, ... }:

{
  networking = {

    # Network Manager
    networkmanager.enable = true;

    # Firewall Settings
    firewall = {
      enable = true;
      #allowedTCPPorts = [ 22 ]; 
    };
    
    # Extra hosts
    extraHosts = ''
  '';
  };
}
