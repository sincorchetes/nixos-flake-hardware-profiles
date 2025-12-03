# { pkgs, pkgsUnstable, ... }: 
{ pkgs, ... }: 
let
  gcloud = pkgs.google-cloud-sdk.withExtraComponents [
    pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
  ];

in
{
  fonts.fontconfig.enable = true;
  programs = {
      #mpv.enable = true;
      #firefox.enable = true;
      #obs-studio.enable = true;
      bat.enable = true;
      bottom.enable = true;
      k9s.enable = true;
      ripgrep.enable = true;
      ripgrep-all.enable = true;
      neovim.enable = true;
      asciinema.enable = true;
      #helix.enable = true;
      git.enable = true;
      delta.enable = true;
      htop.enable = true;
      imv.enable = true;
      hwatch.enable = true;
      hyprshot.enable = true;
      kubecolor.enable = true;
      awscli.enable = true;
      jq.enable= true;
    };

    services = {
      copyq.enable = true;
      blueman-applet.enable = true;
      network-manager-applet.enable = true;
    };

    home = {

      packages = with pkgs; [
          fastfetch mpv firefox obs-studio
          google-chrome brave                                                                                     # Web Browsers
          libreoffice typora                                                                                      # Office Tools
          gimp inkscape wl-color-picker                                                                           # Multimedia Tools
          vlc                                                                                                     # Video Players
          copyq _1password-gui easyeffects qpwgraph pavucontrol appimage-run endeavour heroic                     # Desktop Tools
          unrar unzip                                                                                             # File Compression Software
          flat-remix-gnome flat-remix-icon-theme                                                                  # Desktop Theme Software
          eza tree ncdu                                                                                           # Shell Tools
          xh procs dust duf tldr sd glow hyperfine navi dogdns just chezmoi asciinema borgbackup                  # Shell Tools
          wl-clipboard desktop-file-utils playerctl devenv                                                        # Hyprland Desktop
          kubectl kubernetes-helm minikube                                                   # DevOps Tools
          vscode-fhs code-cursor jetbrains.pycharm-professional jetbrains.webstorm                                # IDE Software
          pre-commit postman figma-linux stripe-cli                                                               # Development Tools
          jetbrains.datagrip dbeaver-bin                                                                          # Database Management Tools
          telegram-desktop slack discord                                                                          # Instant Messaging
          transmission_4-gtk tcpdump nmap p0f wireshark rustscan veracrypt openssl gnupg                          # NetSec Tools
          nix-search-cli                                                                                          # Nixpkg Manager Tools
          nerd-fonts._0xproto nerd-fonts.droid-sans-mono nerd-fonts.ubuntu-sans                                   # Fonts
          nerd-fonts.ubuntu nerd-fonts.jetbrains-mono nerd-fonts.fira-code roboto                                 # Fonts
          font-awesome noto-fonts-emoji-blob-bin powerline-fonts                                                  # Fonts
          gnomeExtensions.pop-shell gnomeExtensions.easyeffects-preset-selector gnomeExtensions.appindicator      # GNOME Extensions
        ];
    };
}
