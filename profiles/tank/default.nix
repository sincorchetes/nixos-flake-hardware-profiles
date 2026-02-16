{ config, pkgs, inputs, ... }:

{
  imports = [
    ./disko.nix
    ../modules/hardware/nvidia.nix
    ../modules/hardware/bluetooth.nix
    ../modules/system/network.nix
    ../modules/system/vpn.nix
    ../modules/system/security.nix
    ../modules/system/users.nix
    ../modules/system/core.nix
  ];

  networking.hostName = "tank0";
  networking.networkmanager.wifi.powersave = false;

  hardware = {
    cpu.amd.updateMicrocode = true;
    xpadneo.enable = true;
    enableAllFirmware = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_6_18;
    zfs.package = pkgs.zfs_2_4;
    kernelParams = [
      "preempt=full"
      "usbcore.autosuspend=-1"
      "iommu=pt"
      "nvidia-drm.modeset=1"
      "kvm_amd.avic=1"
    ];
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "uas" "ahci" ];
    blacklistedKernelModules = [ "nouveau" "amdgpu" ];
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
  };
}
