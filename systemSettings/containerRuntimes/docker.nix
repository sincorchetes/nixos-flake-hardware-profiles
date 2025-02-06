{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       docker
    ];
  };

  virtualisation = {
    docker = {
      enable = true;
    };
    
  };

  users = {
    users = {
      sincorchetes = {
        extraGroups = ["docker"];
      };
    };
  };
}
