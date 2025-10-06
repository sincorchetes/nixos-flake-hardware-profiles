{ config, pkgs, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../system/importer.nix
  ];

  hardware = {
    cpu.intel.updateMicrocode = true;

    firmware = with pkgs; [
      sof-firmware
    ];

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    enableAllFirmware = true;

    graphics = {
      extraPackages = with pkgs; [
        intel-media-driver
        intel-media-sdk
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        vpl-gpu-rt
      ];
    };
  };

  networking.hostName = "probook0";

  boot = {
    blacklistedKernelModules = [];

    initrd = {
      luks.devices."nixos-root" = {
        device = "/dev/disk/by-uuid/da456e40-1bae-4caa-a0cd-5a99c2deebf3";
        allowDiscards = true;
      };
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "uas" "ahci" "thunderbolt" "usbhid" ];
    };

    kernelModules = [ "kvm-intel" "r8169" ];

    kernelParams = [
      "i915.enable_psr=0"
      "i915.enable_dc=0"
      "zswap.enabled=1"
      "zswap.compresor=lz4"
      "zswap.max_pool_percent=20"
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/bc7203e8-778e-462a-a1d1-6badb1508085";
      fsType = "ext4";
      options = [ "defaults" "noatime" "lazytime" "commit=60" "errors=remount-ro" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/0932-D6AA";
      fsType = "vfat";
      options = [ "noauto" ];
    };
  };
  
  swapDevices = lib.optionals (builtins.pathExists "/swapfile") [
    {
      file = "/swapfile";
      size = 4096;
      options = [ "discard" ];
    }
  ];

}