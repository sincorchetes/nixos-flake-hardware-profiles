{ pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowPing = false;
    };
  };

  environment.systemPackages = with pkgs; [
    inetutils
    bridge-utils
    ethtool
    dig
  ];
}
