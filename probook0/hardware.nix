{ config, lib, pkgs, ... }:
{
    hardware = {
        enableAllFirmware = true;
        graphics = {
          enable = true;
          extraPackages = with pkgs; [
                vpl-gpu-rt
          ];
        };
      };
}
    };
}
