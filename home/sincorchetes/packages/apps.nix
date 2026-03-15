{pkgs, ...}: {
  home.packages = with pkgs; [
    #firefox
    obs-studio
    google-chrome
    brave
    libreoffice
    typora
    gimp
    inkscape
    vlc
    spotify
    spotify-tray
    copyq
    qpwgraph
    pavucontrol
    appimage-run
    endeavour
    unrar
    unzip
    postman
    discord
    transmission_4-gtk
  ];
}
