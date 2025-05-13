{ config, lib, pkgs, modulesPath, ... }:

{
 
  hardware = {
    #xpadneo.enable = true;
    firmware = [ pkgs.linux-firmware ];
      
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
      ];
    };
  };
}
