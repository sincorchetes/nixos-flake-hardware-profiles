{ config, lib, pkgs, modulesPath, ... }:

{
  hardware = {
    graphics = {
      enable = true;
      driSupport = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
      ];
    };
  };
}
