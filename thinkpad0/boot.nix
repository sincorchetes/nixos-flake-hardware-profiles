{ config, pkgs, ... }:

{
  boot = {

    # RAM Image Kernel Modules

    initrd = {
      luks.devices."nixos-root".device = "/dev/disk/by-uuid/67c0f096-ab39-40b4-9187-8cc6f3cbee24";
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    };

    
    # Set Kernel Modules
    
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ pkgs.vmware-workstation ];
    
    # Set Kernel Parameters
    kernelParams = [
      # Disable AMDGPU 
      "i915.enable_psr=0"
      "zswap.enabled=1"
      "zswap.compresor=lz4"
      "zswap.max_pool_percent=20"
    ];
  };
}
