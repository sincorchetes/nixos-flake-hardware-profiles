{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    pkgs.gnome.gnome-keyring
  ];

  systemd.user.services.gnome-keyring-daemon = {
    description = "GNOME Keyring Daemon";
    after = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh";
      Restart = "on-failure";
    };

    install = {
      wantedBy = [ "default.target" ];
    };
  };
}
