{ pkgs, ... }: 
{

  home.packages = with pkgs; [
    # Navegadores y productividad
    google-chrome brave firefox
    libreoffice typora copyq transmission_4-gtk appimage-run
    figma-linux _1password-gui
    # Comunicación
    telegram-desktop slack discord
    # Multimedia
    vlc mpv spotify stremio gimp inkscape obs-studio easyeffects qpwgraph pavucontrol
    # IDEs y editores
    vscode-fhs code-cursor helix vim
    jetbrains.pycharm-professional jetbrains.webstorm jetbrains.datagrip dbeaver-bin
    # Terminales y utilidades personales
    alacritty kitty
    geekbench endeavour remmina
    # Otros
    nix-search-cli asciinema postman
  ];
}
