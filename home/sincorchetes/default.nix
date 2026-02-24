{ pkgs, inputs, ... }:
{
  imports = [
    ./shell/zsh.nix
    ./shell/tmux.nix
    ./packages/apps.nix
    ./packages/cli.nix
    ./packages/dev.nix
    ./packages/fonts.nix
    ./packages/gnome.nix
    #    ./desktop/hyprland.nix
    #    ./desktop/foot.nix
  ];

  home = {
    username = "sincorchetes";
    homeDirectory = "/home/sincorchetes";
    stateVersion = "25.11";

    sessionVariables = {
      EDITOR = "nvim";
      XDG_CONFIG_HOME = "/home/sincorchetes/.config";
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
    };

  };

  services = {
    copyq.enable = true;
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };

  programs.home-manager.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        identityAgent = "~/.1password/agent.sock";
      };
    };
  };
}
