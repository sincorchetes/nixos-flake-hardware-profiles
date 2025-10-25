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

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [];
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
        stateVersion = "25.05";
        username = "sincorchetes";
        homeDirectory = "/home/sincorchetes";
      };
      
      imports = [ 
        ./home_manager_packages.nix 
        ./xdg_desktop_entries.nix 
        ./hypr/hyprland.nix 
        ./hypr/hyprpaper.nix
      ];
    };
  };
}
