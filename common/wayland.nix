{ config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      hyprland
      waybar
      hyprshot
      hyprpaper
      wofi
      dunst
      copyq
      hyprpaper
      font-awesome
      noto-fonts-emoji
      nerd-fonts
    ];
  };
}
