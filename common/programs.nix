{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    oh-my-zsh = {
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
}
