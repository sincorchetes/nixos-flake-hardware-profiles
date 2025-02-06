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

      initExtra = ''
        export SSH_AUTH_SOCK=/run/user/1000/ssh-agent
      '';

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
        code = "code --enable-features=UseOzonePlatform --ozone-platform=wayland";
        uts = "sudo git -C /etc/nixos pull ; sudo nixos-rebuild switch --flake /etc/nixos/#$(hostname)";
      };

      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
        plugins = [ "git" ];
      };
    };
  };
}
