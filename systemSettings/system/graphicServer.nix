{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
      xdg-utils
      glib
      powerline-fonts
      roboto
      font-awesome
      noto-fonts-emoji-blob-bin
      desktop-file-utils
    ];
  };

  fonts = {
    packages = with pkgs; [
           nerd-fonts._0xproto
           nerd-fonts.droid-sans-mono
           nerd-fonts.ubuntu-sans
           nerd-fonts.ubuntu
           nerd-fonts.jetbrains-mono
         ];
  };
  
  services = {
    
    xserver = {
      xkb = {
        layout = "es";
        variant = "";
      };
    };

    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
      };
    };
  };
}
