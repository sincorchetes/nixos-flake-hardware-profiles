{ config, pkgs, inputs, ... }:

{
  imports = [
    ./disko.nix
    ../../system/importer.nix
  ];

  networking.hostName = "tank0";

  hardware = {
    cpu.amd.updateMicrocode = true;
    xpadneo.enable = true;
    enableAllFirmware = true;
    nvidia = {
      package = pkgs.linuxPackages_latest.nvidia_x11;
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_6_18;
    zfs.package = pkgs.zfs_2_4;
    kernelParams = [
      "preempt=full"
      "usbcore.autosuspend=-1"
      "iommu=pt"
      "nvidia-drm.modeset=1"
    ];
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "uas" "ahci" ];
    blacklistedKernelModules = [ "nouveau" "amdgpu" ];
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
  };
}
