{ config, nixpkgs, lib, home-manager, inputs, ... }:

{
  system = {
    stateVersion = "24.11";
  };
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

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      sincorchetes = import ../../homeManager/home.nix;
    };
  };
}