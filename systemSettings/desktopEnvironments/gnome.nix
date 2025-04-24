{ pkgs, ... }:

{
  
  services = {
    gnome = {
      gnome-keyring = {
        enable = true;
      };
    };

    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    flat-remix-gnome
    flat-remix-icon-theme
    gnomeExtensions.pop-shell
  ];

  security.pam.services.gdm.enableGnomeKeyring = true;
  
}
