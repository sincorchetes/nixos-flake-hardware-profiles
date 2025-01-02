{ config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      hyprland
      waybar
    ];
  };
}
