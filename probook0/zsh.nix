{ config, pkgs, ... }:

{

  programs = {
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
            "sudo"
            "systemd"
            "git"
            "gcloud"
            "aws"
            "colorize"
          ];
        };
      };
    };
}
