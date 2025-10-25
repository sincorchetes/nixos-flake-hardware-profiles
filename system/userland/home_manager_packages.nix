# { pkgs, pkgsUnstable, ... }: 
{ pkgs, ... }: 
let
  gcloud = pkgs.google-cloud-sdk.withExtraComponents [
    pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
  ];
in
{
  programs = {
      #rio.enable = true;
      #tmux.enable = true;
      #fastfetch.enable = true;
      #mpv.enable = true;
      #firefox.enable = true;
      #obs-studio.enable = true;
      bat.enable = true;
      bottom.enable = true;
      k9s.enable = true;
      ripgrep.enable = true;
      ripgrep-all.enable = true;
      neovim.enable = true;
      #asciinema.enable = true;    # Available in 25.11
      #helix.enable = true;
      git.enable = true;
      #delta.enable = true;        # Available in 25.11
      htop.enable = true;
      imv.enable = true;
      #hwatch.enable = true;       # Available in 25.11
      #hyprshot.enable = true;     # Available in 25.11
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

      packages =
        (with pkgs; [
          fastfetch mpv firefox obs-studio
          google-chrome brave                                                                                     # Web Browsers
          libreoffice typora                                                                                      # Office Tools
          gimp inkscape wl-color-picker                                                                           # Multimedia Tools
          vlc spotify stremio                                                                                     # Video Players
          copyq _1password-gui easyeffects qpwgraph pavucontrol appimage-run endeavour heroic                     # Desktop Tools
          unrar                                                                                                   # File Compression Software
          flat-remix-gnome flat-remix-icon-theme                                                                  # Desktop Theme Software
          eza tree ncdu delta hwatch                                                                              # Shell Tools
          xh procs dust duf tldr sd glow hyperfine navi dogdns just chezmoi asciinema                             # Shell Tools
          wl-clipboard desktop-file-utils hyprshot                                                 # Hyprland Desktop
          playerctl                                                                              # Hyprland Desktop
          terraform terragrunt kubectl kubernetes-helm gcloud minikube                                            # DevOps Tools
          vscode-fhs code-cursor jetbrains.pycharm-professional jetbrains.webstorm                                # IDE Software
          pre-commit postman figma-linux stripe-cli                                                               # Development Tools
          jetbrains.datagrip dbeaver-bin                                                                          # Database Management Tools
          telegram-desktop slack discord                                                                          # Instant Messaging
          transmission_4-gtk                                                                 # Network Tools
          nix-search-cli                                                                                          # Nixpkg Manager Tools
          veracrypt                                                                                               # Security Tools
        ]);
        #++
        #(with pkgsUnstable; [
        #  brave
        #]);
    };
}
