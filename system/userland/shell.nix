{ pkgs, ... }:

{

  home = {
    sessionVariables = {
      EDITOR = "vim";
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
      XCURSOR_THEME = "Adwaita";
      XCURSOR_SIZE = "24";
      XDG_CONFIG_HOME = "$HOME/.config";
      SOPS_AGE_KEY_FILE = "/home/sincorchetes/.config/sops/age/keys.txt";
    };

    packages = with pkgs; [
      zsh-powerlevel10k
    ];
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initContent = ''
        source "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh;
        unsetopt PROMPT_CR;
        compdef k=kubectl;
        compdef kubecolor=kubectl;
        compdef g=git;
        compdef gg=gcloud;
      '';
      shellAliases = {
        cat = "bat -p";
        c = "clear";
        k = "kubecolor";
        g = "git";
        t = "terraform";
        dc = "docker compose";
        ls = "eza";
        ll = "eza -l";
        open = "xdg-open";
        gg = "gcloud";
        #code = "code --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu";
        nxupdate = "sudo nixos-rebuild switch --refresh --flake github:sincorchetes/nixos-flake-hardware-profiles#$(hostname) --impure";
        nxcboot = "sudo nixos-rebuild boot --flake github:sincorchetes/nixos-flake-hardware-profiles#$(hostname) --impure";
        nxcsys = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
        nxfull = "nxupdate ; nxcsys ; nxcboot";
        # sudo = "run0";
        # sudo-graphics = "run0 --setenv=DISPLAY=\\\"$DISPLAY\\\" --setenv=XAUTHORITY=\\\"$XAUTHORITY\\\"";
      };
    };

    navi = {
      enable = true;
      enableZshIntegration = true;
    };

    lazygit = {
      enable = true;
      #enableZshIntegration = true;       # Available in 25.11
    };

    broot = {
      enable = true;
      enableZshIntegration = true;
    };

    yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}