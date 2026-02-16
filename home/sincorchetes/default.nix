{ pkgs, inputs, ... }:

{
  imports = [
    ./shell/zsh.nix
    ./shell/tmux.nix
#    ./desktop/hyprland.nix
#    ./desktop/foot.nix
  ];

  home = {
    username = "sincorchetes";
    homeDirectory = "/home/sincorchetes";
    stateVersion = "25.11";

    sessionVariables = {
      EDITOR = "nvim";
      XDG_CONFIG_HOME = "/home/sincorchetes/.config";
      SOPS_AGE_KEY_FILE = "/home/sincorchetes/.config/sops/age/keys.txt";
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
    };

    packages = with pkgs; [
      fastfetch mpv firefox obs-studio google-chrome brave libreoffice typora anki-bin git bat k9s                                                                         
      gimp inkscape wl-color-picker vlc spotify spotify-tray copyq _1password-gui easyeffects 
      qpwgraph pavucontrol appimage-run endeavour unrar unzip flat-remix-gnome flat-remix-icon-theme                                                                 
      eza tree ncdu xh procs dust duf tldr sd glow hyperfine navi dogdns just chezmoi asciinema borgbackup                  
      wl-clipboard desktop-file-utils playerctl devenv kubectl kubernetes-helm minikube google-cloud-sdk
      vscode-fhs code-cursor jetbrains.pycharm jetbrains.webstorm antigravity-fhs pre-commit postman figma-linux 
      jetbrains.datagrip dbeaver-bin telegram-desktop slack discord transmission_4-gtk tcpdump nmap p0f wireshark 
      rustscan openssl gnupg nix-search-cli nerd-fonts._0xproto nerd-fonts.droid-sans-mono nerd-fonts.ubuntu-sans                                   
      nerd-fonts.ubuntu nerd-fonts.jetbrains-mono nerd-fonts.fira-code roboto font-awesome noto-fonts-emoji-blob-bin 
      powerline-fonts gnomeExtensions.pop-shell gnomeExtensions.easyeffects-preset-selector gnomeExtensions.appindicator
    ];
  };

  services = {
    copyq.enable = true; 
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };

  programs.home-manager.enable = true;
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';
  };
}
