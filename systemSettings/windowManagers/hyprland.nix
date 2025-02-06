{ pkgs, lib, ... }:

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
      desktop-file-utils
      pavucontrol
      blueman
      playerctl
      alacritty
      alacritty-theme
    ];
  };

  programs = {
    hyprland = {
      enable = true;
    };

    hyprlock = {
      enable = true;
    };
  };

  services = {
    hypridle = {
      enable = true;
    };
  };
}
