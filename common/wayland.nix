{ config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      hyprland
      waybar
      libglvnd
      hyprshot
      hyprpaper
      wofi
      copyq
      hyprpaper
      wl-clipboard
      mako
      kitty
    ];
  };
}
