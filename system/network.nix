{ pkgs, ... }:

{
    networking = {
        networkmanager.enable = true;
        # Firewall Settings
        firewall = {
        enable = true;
        #allowedTCPPorts = [ 22 ]; 
        };
        extraHosts = ''
        '';
    
  };
  environment = {
    systemPackages = with pkgs; [
       bluez
       bluez-tools
       bridge-utils
       inetutils
    ];
  };
}
