{ pkgs, lib, ... }:

{
  boot.bootspec.enable = true;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  
  boot.loader.systemd-boot.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
