{pkgs, ...}: {
  home.packages = with pkgs; [
    mpv
    firefox
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
    _64gram
    slack
    discord
    transmission_4-gtk
  ];
}
