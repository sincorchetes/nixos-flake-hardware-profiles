# { pkgs, pkgsUnstable, ... }: 
{ pkgs, ... }: 
let
  gcloud = pkgs.google-cloud-sdk.withExtraComponents [
    pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
  ];
in
{
  home.packages =
    (with pkgs; [
      google-chrome firefox brave                                                                             # Web Browsers
      libreoffice typora                                                                                      # Office Tools
      gimp inkscape obs-studio wl-color-picker                                                                # Multimedia Tools
      vlc mpv spotify stremio                                                                                 # Video Players
      copyq _1password-gui easyeffects qpwgraph pavucontrol appimage-run endeavour heroic                     # Desktop Tools
      unrar                                                                                                   # File Compression Software
      flat-remix-gnome flat-remix-icon-theme                                                                  # Desktop Theme Software
      rio alacritty kitty                                                                                     # GUI Terminal Tools
      yazi imv asciinema tmux eza tree btop htop ncdu fastfetch bat zoxide fzf ripgrep zellij delta bottom    # Shell Tools
      lazygit xh procs atuin dust duf tldr sd glow broot hyperfine navi dog                                   # Shell Tools
      waybar hyprshot hyprpaper wofi hyprpaper wl-clipboard mako desktop-file-utils                           # Hyprland Desktop
      blueman playerctl hypridle hyprlock                                                                     # Hyprland Desktop
      terraform terragrunt kubectl kubecolor k9s kubernetes-helm awscli2 gcloud minikube                      # DevOps Tools
      vscode-fhs code-cursor helix vim jetbrains.pycharm-professional jetbrains.webstorm                      # IDE Software
      jq pre-commit postman figma-linux stripe-cli                                                            # Development Tools
      jetbrains.datagrip dbeaver-bin                                                                          # Database Management Tools
      telegram-desktop slack discord                                                                          # Instant Messaging
      transmission_4-gtk networkmanagerapplet                                                                 # Network Tools
      nix-search-cli                                                                                          # Nixpkg Manager Tools
      veracrypt                                                                                               # Security Tools
      
    ]);
    #++
    #(with pkgsUnstable; [
    #  brave
    #]);
}
