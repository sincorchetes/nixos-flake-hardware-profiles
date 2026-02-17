{ pkgs, ... }:

{
  home = {
    file.".p10k.zsh".source = ./.p10k.zsh;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initContent = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      unsetopt PROMPT_CR
    '';

    shellAliases = {
      cat = "bat --paging=never -p";
      c = "clear";
      ls = "eza";
      ll = "eza -l";
      open = "xdg-open";
      vim = "nvim";

      k = "kubecolor";
      g = "git";
      t = "terraform";
      dc = "docker compose";
      gg = "google-cloud-sdk";

      nxupdate = "sudo nixos-rebuild switch --refresh --flake .#$(hostname) --impure";
      nxcboot  = "sudo nixos-rebuild boot --flake .#$(hostname) --impure";
      nxcsys   = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
      nxfull   = "nxupdate && nxcsys && nxcboot";
    };
  };

  programs = {
    navi.enable = true;
    navi.enableZshIntegration = true;

    lazygit.enable = true;

    broot.enable = true;
    broot.enableZshIntegration = true;

    yazi.enable = true;
    yazi.enableZshIntegration = true;

    fzf.enable = true;
    fzf.enableZshIntegration = true;

    zoxide.enable = true;
    zoxide.enableZshIntegration = true;

    atuin.enable = true;
    atuin.enableZshIntegration = true;

    neovim.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
};
  };
}
