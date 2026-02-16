{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidia_x11;
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
  };
  
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.enableNvidia = true;

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  environment.systemPackages = with pkgs; [
    vdpauinfo
    mesa
  ];
}