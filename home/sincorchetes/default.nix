{ pkgs, inputs, ... }:
{
  imports = [
    ./shell/zsh.nix
    ./shell/tmux.nix
    ./packages/apps.nix
    ./packages/cli.nix
    ./packages/dev.nix
    ./packages/easyeffects.nix
    ./packages/fonts.nix
    ./packages/gnome.nix
    ./packages/mpv.nix
  ];

  home = {
    username = "sincorchetes";
    homeDirectory = "/home/sincorchetes";
    stateVersion = "26.05";

    sessionVariables = {
      EDITOR = "nvim";
      XDG_CONFIG_HOME = "/home/sincorchetes/.config";
      OLLAMA_API_BASE = "http://127.0.0.1:11434";
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
    };

  };

  services = {
    copyq.enable = true;
  };

  programs.home-manager.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        KexAlgorithms = "curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256";
        IdentityAgent = "~/.1password/agent.sock";
      };
    };
  };
}
