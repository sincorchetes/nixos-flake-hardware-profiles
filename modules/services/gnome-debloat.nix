{ pkgs, lib, ... }:

{
  services = {
    avahi.enable = false;
    gnome = {
      gnome-remote-desktop.enable = false;
      gnome-browser-connector.enable = false;
      gnome-initial-setup.enable = false;
      gnome-user-share.enable = false;
      rygel.enable = false;
    };
  };

  systemd.user.services = {
    "gvfs-afc-volume-monitor".wantedBy = lib.mkForce [ ];
    "gvfs-gphoto2-volume-monitor".wantedBy = lib.mkForce [ ];
    "org.gnome.SettingsDaemon.Smartcard".wantedBy = lib.mkForce [ ];
    "org.gnome.SettingsDaemon.Wwan".wantedBy = lib.mkForce [ ];
  };

  environment.gnome.excludePackages = with pkgs; [
    totem
    epiphany
    aisleriot
    gnome-chess
    iagno
    hitori
    atomix
    tali
    four-in-a-row
    gnome-klotski
    gnome-mines
    gnome-nibbles
    gnome-robots
    gnome-sudoku
    gnome-taquin
    gnome-tetravex
    swell-foop
    lightsoff
    quadrapassel
    gnome-tour
    gnome-music
    gnome-maps
    yelp
    simple-scan
  ];
}
