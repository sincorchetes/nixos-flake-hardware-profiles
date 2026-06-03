{pkgs, ...}: {
  home.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    nerd-fonts.ubuntu-sans
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    roboto
    font-awesome
    noto-fonts-emoji-blob-bin
    powerline-fonts
  ];
}
