{ config, nixpkgs, lib, home-manager, inputs, ... }:


let
  localKeyfile = "/home/sincorchetes/.config/sops/age/keys.txt";

  githubKeyfile = "/github/home/.config/sops/age/keys.txt";

  keyfile =
    if builtins.pathExists localKeyfile then localKeyfile
    else if builtins.pathExists githubKeyfile then githubKeyfile
    else throw "Keyfile AGE does not found";
in

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
    age.keyFile = keyfile;
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      root_password = {};
    };
  };


  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.sincorchetes = {
      home = {
        stateVersion = "25.05";
        username = "sincorchetes";
        homeDirectory = "/home/sincorchetes";
      };
      
      imports = [ ./home_manager_packages.nix ./xdg_desktop_entries.nix ];
    };
  };
}
