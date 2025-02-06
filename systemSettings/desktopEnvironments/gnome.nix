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

  environment.systemPackages = with pkgs.gnomeExtensions; [
    pop-shell
  ];
}
