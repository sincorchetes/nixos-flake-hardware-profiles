{ config, lib, pkgs, modulesPath, ... }:

{
 
  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
    xpadneo.enable = true;
    firmware = [ pkgs.linux-firmware ];
      
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
      ];
    };
  };
}
