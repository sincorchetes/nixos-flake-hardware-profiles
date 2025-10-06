{ pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;

    firewall = {
      enable = true;
      # allowedTCPPorts = [ 22 ];
    };

    extraHosts = ''
    '';
  };

  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
    bridge-utils
    inetutils
  ];
}