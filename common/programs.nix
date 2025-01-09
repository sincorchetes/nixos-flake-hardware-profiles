{ config, pkgs, ... }:

{
  programs = {
    hyprland.enable = true;
    hypridle.enable = true;
    hyprlock.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions = {
        enable = true;
      };
      syntaxHighlighting = {
        enable = true;
      };
      
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "colorize"
        ];
      };
    };
  };
}
