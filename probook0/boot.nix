{ config, pkgs, ... }:

{
  boot = {

   blacklistedKernelModules = [];

    # RAM Image Kernel Modules

    initrd = {
      luks.devices."nixos-root".device = "/dev/disk/by-uuid/da456e40-1bae-4caa-a0cd-5a99c2deebf3";
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "uas" "ahci" "thunderbolt" "usbhid"];
    };

    # Set Kernel Modules
    
    kernelModules = [ "kvm-intel" "r8169" ];
    extraModulePackages = [ pkgs.vmware-workstation ];
    
    # Set Kernel Parameters
    kernelParams = [
      "i915.enable_psr=0"
      "i915.enable_dc=0"
      "zswap.enabled=1"
      "zswap.compresor=lz4"
      "zswap.max_pool_percent=20"
    ];
  };
}
