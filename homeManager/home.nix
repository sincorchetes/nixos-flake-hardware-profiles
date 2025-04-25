{ config, pkgs, ... }:

{
  imports =
    [
      ./applications/browsers.nix
      ./applications/development.nix
      ./applications/gnome-keyring.nix
      ./applications/multimedia.nix
      ./applications/office.nix
      ./applications/social.nix
      ./shellTools/backup.nix
      ./shellTools/zsh.nix
    ];

  home = {
    stateVersion = "24.11";
    username = "sincorchetes";
    homeDirectory = "/home/sincorchetes";
    
  };
}
