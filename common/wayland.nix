{ config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      wayland
      waybar
      hyprshot
      hyprpaper
      wofi
      dunst
      copyq
      hyprpaper
    ];
  };
}
