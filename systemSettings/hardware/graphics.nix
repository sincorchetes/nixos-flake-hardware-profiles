{ config, lib, pkgs, modulesPath, ... }:

{
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
      ];
    };
  };
}
