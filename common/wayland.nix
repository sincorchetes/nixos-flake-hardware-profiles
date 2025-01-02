{ config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      hyprland
      waybar
      hyprshot
      hyprpaper
      wofi
      copyq
      hyprpaper
      font-awesome
      noto-fonts-emoji
      nerdfonts
      mako
    ];
  };
}
