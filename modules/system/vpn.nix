{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openfortivpn
  ];
}