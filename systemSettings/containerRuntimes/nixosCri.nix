{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       docker
    ];
  };

  virtualisation = {
    containers = {
      enable = true;
    };
    
  };
}
