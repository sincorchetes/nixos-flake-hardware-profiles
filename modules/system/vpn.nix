{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openvpn
    networkmanager-openvpn
    openfortivpn
    networkmanager-fortisslvpn
  ];

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
      networkmanager-fortisslvpn
    ];
  };

  boot.kernelModules = [ "ppp_generic" ];
  networking.firewall.allowedTCPPorts = [ 443 10443 ];
}
