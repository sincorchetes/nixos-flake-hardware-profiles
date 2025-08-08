{ config, lib, pkgs, ... }:

{

  hardware.nvidia-container-toolkit.enable = true;

  environment = {
    systemPackages = with pkgs; [
       docker
       docker-buildx
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
