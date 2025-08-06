{ config, pkgs, ... }:

{
  imports =
    [
      ./applications/browsers.nix
      ./applications/desktop-utils.nix
      ./applications/development.nix
      #./applications/gnome-keyring.nix
      ./applications/xdg-desktop-entries.nix
      ./applications/multimedia.nix
      ./applications/office.nix
      ./applications/social.nix
      ./shellTools/backup.nix
      ./shellTools/veracrypt.nix
      ./shellTools/zsh.nix
    ];

  home = {
    stateVersion = "25.05";
    username = "sincorchetes";
    homeDirectory = "/home/sincorchetes";
    
  };
}
