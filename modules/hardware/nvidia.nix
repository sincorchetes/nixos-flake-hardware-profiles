{ config, pkgs, ... }:

{
  nixpkgs.config.cudaSupport = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    graphics.enable32Bit = true;
    nvidia-container-toolkit.enable = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidia_x11;
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
    };
  };

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nowatchdog"
  ];

  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  environment.systemPackages = with pkgs; [
    vdpauinfo
    mesa
  ];

  powerManagement.powerDownCommands = ''
    ${pkgs.kmod}/bin/modprobe -r btusb
  '';
  powerManagement.resumeCommands = ''
    ${pkgs.kmod}/bin/modprobe btusb
  '';
}
