{ config, lib, pkgs, ... }:


{
    hardware = {
      cpu = {
        intel = {
          updateMicrocode = true;
        };
      };
      
      graphics = {
        extraPackages = with pkgs ; [
            intel-media-driver
            intel-media-sdk
            vaapiIntel
            vaapiVdpau
            libvdpau-va-gl
        ];
      };
    };

    
}