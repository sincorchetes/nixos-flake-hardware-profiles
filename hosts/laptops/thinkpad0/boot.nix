{ config, pkgs, ... }:

{

  # Boot section
  boot = {

    # RAM Image Kernel Modules
    initrd = {

      # Set up your luks partition

      # Bultin kernel modules at startup
      luks.devices."nixos-root".device = "/dev/disk/by-uuid/67c0f096-ab39-40b4-9187-8cc6f3cbee24";
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    };

    
    # Set Kernel Modules
    kernelModules = [ "kvm-intel" ];

    # Enable extra kernel module packages from packages
    extraModulePackages = [];
    
    # Set Kernel Parameters
    kernelParams = [
      "i915.enable_psr=0"         # Disable PSR, avoid flickering screen issues
      "i915.enable_dc=0"          # Disable DC to improve stability
      "zswap.enabled=1"           # Enable Zswap
      "zswap.compresor=lz4"       # Set Zswap compression algorithm
      "zswap.max_pool_percent=20" # Set Zswap RAM memory usage
    ];
  };
}
