{ config, pkgs, ... }:

{
  # Nvidia environment variables
  # Only needed for Wayland Windows Manager
  #environment = {
  #  variables = {
  #    GBM_BACKEND = "nvidia-drm";
  #  };
  #};

  
  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];
    };
  };

  hardware= {
    nvidia = {
      package = pkgs.linuxPackages_latest.nvidia_x11_vulkan_beta; 
      #package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #    version = "570.86.16"; # use new 570 drivers
      #    sha256_64bit = "sha256-RWPqS7ZUJH9JEAWlfHLGdqrNlavhaR1xMyzs8lJhy9U=";
      #    openSha256 = "sha256-DuVNA63+pJ8IB7Tw2gM4HbwlOh1bcDg2AN2mbEU9VPE=";
      #    settingsSha256 = "sha256-9rtqh64TyhDF5fFAYiWl3oDHzKJqyOW3abpcf2iNRT8=";
      #    usePersistenced = false;
      #  };
      modesetting = {
        enable = true;
      };
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      open = true;
      nvidiaSettings = true;
    };
  };
}
