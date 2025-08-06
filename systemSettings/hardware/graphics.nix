{ config, lib, pkgs, modulesPath, ... }:

{
  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
      ];
    };
  };
}
