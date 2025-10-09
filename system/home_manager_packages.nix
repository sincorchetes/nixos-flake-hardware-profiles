{ pkgs, pkgsUnstable, ... }: 
{
  home.packages =
    (with pkgs; [
      google-chrome firefox
      libreoffice typora copyq transmission_4-gtk appimage-run
      figma-linux _1password-gui
      telegram-desktop slack discord
      vlc mpv spotify stremio gimp inkscape obs-studio easyeffects qpwgraph pavucontrol
      vscode-fhs code-cursor helix vim
      jetbrains.pycharm-professional jetbrains.webstorm jetbrains.datagrip dbeaver-bin
      alacritty kitty rio
      geekbench endeavour remmina
      nix-search-cli asciinema postman
    ])
    ++
    (with pkgsUnstable; [
      brave
    ]);
}
