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
    #telegram-desktop # broken build upstream v6.4.1
    slack
    discord
    transmission_4-gtk
  ];
}
