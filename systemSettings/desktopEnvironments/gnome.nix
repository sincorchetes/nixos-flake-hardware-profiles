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
  systemd.user.services.gnome-keyring-daemon = {
    Unit.Description = "GNOME Keyring Daemon";
    Service = {
      ExecStart = "/run/wrappers/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" ];
  };
  
}
