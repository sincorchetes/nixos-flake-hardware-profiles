{ config, lib, pkgs, ... }:
{
    hardware = {
      firmware = with pkgs; [
        sof-firmware
      ];
    };
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
