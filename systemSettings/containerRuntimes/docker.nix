{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       docker
       docker-buildx
    ];
  };

  virtualisation = {
    docker = {
      enable = true;
      enableNvidia = true;
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
