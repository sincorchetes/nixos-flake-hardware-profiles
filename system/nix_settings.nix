{ config, nixpkgs, lib, home-manager, inputs, ... }:

{
  system.stateVersion = "25.05";

  nix = {
    settings = {
      allowed-users = [ "@wheel" ];
      download-buffer-size = 10737418240;
      extra-experimental-features = [ "nix-command" "flakes" ];
    };

    # devenv
    extraOptions = ''
      trusted-users = root sincorchetes
    '';
  };

  sops = {
    age.keyFile = builtins.getEnv "SOPS_AGE_KEY_FILE";
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      root_password = {};
      sincorchetes_password = {};
    };
  };


  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.sincorchetes = {
      home = {
        stateVersion = "unstable";
        username = "sincorchetes";
        homeDirectory = "/home/sincorchetes";
      };
      
      imports = [ 
        ./userland/shell.nix 
        ./userland/packages.nix 
        ./userland/xdg_desktop_entries.nix 
        ./userland/hypr/hyprland.nix 
        ./userland/hypr/hyprpaper.nix
        ./userland/hypr/hypridle.nix
        ./userland/hypr/hyprlock.nix
        ./userland/wofi/wofi.nix
        ./userland/waybar/waybar.nix
        ./userland/rio/rio.nix
        ./userland/tmux/tmux.nix
        ./userland/mako/mako.nix
        ./userland/foot/foot.nix
      ];
    };
  };
}
