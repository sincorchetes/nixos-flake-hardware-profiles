{pkgs, ...}: {
  home.packages = with pkgs; [
    gnomeExtensions.pop-shell
    gnomeExtensions.appindicator
    gnome-network-displays
    gradia
    constrict
  ];
}
