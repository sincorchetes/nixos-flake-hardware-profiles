{ config, lib, pkgs, modulesPath, ... }:

{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
      ];
    };
  };
}
