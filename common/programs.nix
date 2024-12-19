{ config, pkgs, ... }:

{
  program = {
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
