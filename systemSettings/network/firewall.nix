{ lib, ... }:

{
  networking = {

    # Firewall Settings
    firewall = {
      enable = true;
      #allowedTCPPorts = [ 22 ]; 
    };
    
  };
}
