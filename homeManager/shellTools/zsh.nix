{ config, pkgs, ... }:

{

  home = {
    packages = with pkgs ; [
      tree
      eza
      tmux
      unzip
      gnupg
      unrar
      btop
      binutils
      htop
    ];
    sessionVariables = {
      EDITOR = "vim";
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
      XCURSOR_THEME = "Adwaita";
      XCURSOR_SIZE = "24";
      XDG_CONFIG_HOME = "$HOME/.config";
    };
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;

      #initContent = '' --> Disabled
      #'';

      shellAliases = {
        c = "clear";
        k = "kubectl";
        g = "git";
        t = "terraform";
        dc = "docker compose";
        ls = "eza";
        ll = "eza -l";
        open = "xdg-open";
        gg = "gcloud";
        #code = "code --enable-features=UseOzonePlatform --ozone-platform=wayland";
        nxupdate = "run0 git -C /etc/nixos pull ; nixos-rebuild switch --flake /etc/nixos/#$(hostname)";
        nxcboot = "run0 nixos-rebuild boot --flake /etc/nixos/#$(hostname)";
        nxcsys = "nix-collect-garbage -d ; run0 nix-collect-garbage -d";
        sudo = "run0";
        sudo-graphics = "run0 --setenv=DISPLAY=\\\"$DISPLAY\\\" --setenv=XAUTHORITY=\\\"$XAUTHORITY\\\"";

      };

      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
        plugins = [ "git" ];
      };
    };
  };
}
