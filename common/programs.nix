{ config, pkgs, ... }:

{
  programs = {
    zsh = {
    enable = true;
    enableCompletion = true;

    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "colorize"
        "zsh-autosuggestions" 
        "zsh-syntax-highlighting"
      ];
      };
    };
  };
}
