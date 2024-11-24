{ config, pkgs, ... }:

{
  # Nvidia environment variables
  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
      package = pkgs.linuxPackages_latest.nvidia_x11; 
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = true;
    }; 
}