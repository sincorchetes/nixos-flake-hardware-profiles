{ config, pkgs, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    "../../system/importer.nix"
  ];
  
  hardware = {
    cpu.intel.updateMicrocode = true;

    graphics = {
      extraPackages = with pkgs; [
        intel-media-driver
        intel-media-sdk
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  networking.hostName = "thinkpad0";

  boot = {
    initrd = {
      luks.devices."nixos-root" = {
        device = "/dev/disk/by-uuid/67c0f096-ab39-40b4-9187-8cc6f3cbee24";
        allowDiscards = true;
      };
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    };

    kernelModules = [ "kvm-intel" ];

    extraModulePackages = [];

    kernelParams = [
      "i915.enable_psr=0" # Disable PSR, avoid flickering screen issues
      "i915.enable_dc=0" # Disable DC to improve stability
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/b0057114-32f4-4c3b-96ac-ad121ff86061";
      fsType = "ext4";
      options = [ "noatime" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/B954-78FE";
      fsType = "vfat";
      options = [ "noauto" ];
    };

  swapDevices = lib.optionals (builtins.pathExists "/swapfile") [
    {
      file = "/swapfile";
      size = 4096;
      options = [ "discard" ];
    }
  ];

  };
}