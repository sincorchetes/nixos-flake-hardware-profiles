{ config, lib, pkgs, modulesPath, ... }:

{
 
  hardware = {
    pulseaudio = {
      enable = false;
    };
    #xpadneo.enable = true;
    firmware = [ pkgs.linux-firmware ];
      
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
      ];
    };
  };
}
