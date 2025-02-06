{ config, lib, pkgs, ... }:
{
    hardware = {
        bluetooth = {
              enable = true;
              powerOnBoot = true;
            };
        enableAllFirmware = true;
        graphics = {
          extraPackages = with pkgs; [
                vpl-gpu-rt
          ];
        };
    };
}
