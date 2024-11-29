{ config, lib, pkgs, ... }:
{
    hardware = {
        enableAllFirmware = true;
        graphics = {
          extraPackages = with pkgs; [
                vpl-gpu-rt
          ];
        };
    };
}
