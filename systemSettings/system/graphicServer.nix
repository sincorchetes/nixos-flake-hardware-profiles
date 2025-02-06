{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
      xdg-utils
      glib
      powerline-fonts
      ubuntu-sans
      ubuntu-classic
      roboto
      font-awesome
      jetbrains-mono
      noto-fonts-emoji
      nerdfonts
      desktop-file-utils
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
