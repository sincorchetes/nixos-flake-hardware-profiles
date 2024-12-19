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
        (pkgs.zshPlugins.zsh-autosuggestions)
        (pkgs.zshPlugins.zsh-syntax-highlighting)
      ];
      };
    };
  };
}
