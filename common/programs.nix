{ config, pkgs, ... }:

{
  programs = {
    hyprland.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
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
