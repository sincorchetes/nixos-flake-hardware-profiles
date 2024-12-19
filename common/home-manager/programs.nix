{ config, pkgs, ...}:

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true; 
      shellAliases = {
        c = "clear";
        k = "kubectl";
        g = "git";
        dc = "docker compose";
        ls = "eza";
        ll = "eza -l";
        open = "xdg-open";
        gg = "gcloud";
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
