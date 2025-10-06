{ pkgs, ... }:
{

  environment = {
    systemPackages = with pkgs; [
       zsh
       zsh-syntax-highlighting
       zsh-autosuggestions
       zsh-powerlevel10k
    ];
  };

  programs = {

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "colorize"
        ];
      };
    };
  };

  home = {

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
        nxupdate = "sudo nixos-rebuild switch --refresh --flake github:sincorchetes/nixos-flake-hardware-profiles#$(hostname)";
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