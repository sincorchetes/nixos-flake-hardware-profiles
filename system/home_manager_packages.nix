# { pkgs, pkgsUnstable, ... }: 
{ pkgsUnstable, ... }: 
let
  gcloud = pkgsUnstable.google-cloud-sdk.withExtraComponents [
    pkgsUnstable.google-cloud-sdk.components.gke-gcloud-auth-plugin
  ];
in
{
  programs = {
    rio.enable = true;
    tmux.enable = true;
    fastfetch.enable = true;
    mpv.enable = true;
    firefox.enable = true;
    obs-studio.enable = true;
    bat.enable = true;
    bottom.enable = true;
    k9s.enable = true;
    ripgrep.enable = true;
    ripgrep-all.enable = true;
    neovim.enable = true;
    asciinema.enable = true;
    helix.enable = true;
    git.enable = true;
    delta.enable = true;
    htop.enable = true;
    imv.enable = true;
    hwatch.enable = true;
    wofi.enable = true;
    hyprlock.enable = true;
    waybar.enable = true;
    hyprshot.enable = true;
    kubecolor.enable = true;
    awscli.enable = true;
    jq.enable= true;
  };

  home = {
    #services = {
    #  mako = {
    #    enable = true;
    #  };
    #  waybar = {
    #    enable = true;
    #    # settings = { ... };
    #  };
    #  copyq.enable = true;
    #  hyprpaper.enable = true;
    #  hypridle.enable = true;
    #  hyprlock.enable = true;
    #  blueman-applet.enable = true;
    #  network-manager-applet.enable = true;
    #};
    packages =
      (with pkgsUnstable; [
        google-chrome brave                                                                                     # Web Browsers
        libreoffice typora                                                                                      # Office Tools
        gimp inkscape wl-color-picker                                                                           # Multimedia Tools
        vlc spotify stremio                                                                                     # Video Players
        copyq _1password-gui easyeffects qpwgraph pavucontrol appimage-run endeavour heroic                     # Desktop Tools
        unrar                                                                                                   # File Compression Software
        flat-remix-gnome flat-remix-icon-theme                                                                  # Desktop Theme Software
        eza tree ncdu                                                                                           # Shell Tools
        xh procs dust duf tldr sd glow hyperfine navi dogdns just chezmoi                                       # Shell Tools
        hyprpaper wl-clipboard mako desktop-file-utils                                                          # Hyprland Desktop
        blueman playerctl hypridle                                                                              # Hyprland Desktop
        terraform terragrunt kubectl kubernetes-helm gcloud minikube                                            # DevOps Tools
        vscode-fhs code-cursor jetbrains.pycharm-professional jetbrains.webstorm                                # IDE Software
        pre-commit postman figma-linux stripe-cli                                                               # Development Tools
        jetbrains.datagrip dbeaver-bin                                                                          # Database Management Tools
        telegram-desktop slack discord                                                                          # Instant Messaging
        transmission_4-gtk networkmanagerapplet                                                                 # Network Tools
        nix-search-cli                                                                                          # Nixpkg Manager Tools
        veracrypt                                                                                               # Security Tools
        niri
      ]);
      #++
      #(with pkgsUnstable; [
      #  brave
      #]);
   };
}
