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
      zoxide
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
        #code = "code --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu";
        nxupdate = "sudo nixos-rebuild switch --flake github:sincorchetes/nixos-flake-hardware-profiles#$(hostname)";
        nxcboot = "sudo nixos-rebuild boot --flake github:sincorchetes/nixos-flake-hardware-profiles#$(hostname)";
        nxcsys = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
        nxfull = "nxupdate ; nxcsys ; nxcboot";
        # Disabled because It does not compatible with some software likes VeraCrypt.
        # sudo = "run0";
        # sudo-graphics = "run0 --setenv=DISPLAY=\\\"$DISPLAY\\\" --setenv=XAUTHORITY=\\\"$XAUTHORITY\\\"";

      };

      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
        plugins = [ "git" ];
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
