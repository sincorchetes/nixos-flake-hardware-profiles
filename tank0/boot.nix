{ config, pkgs, ... }:

{
  boot = {

   blacklistedKernelModules = [ "amdgpu" "nouveau"];

    # RAM Image Kernel Modules

    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "uas" "ahci" "thunderbolt" "usbhid"];
      luks.devices."nixos-root".device = "/dev/disk/by-uuid/718bc486-a182-4a50-958a-6f97b3a6c671";
    };

    # Set Kernel Modules
    
    kernelModules = [ "kvm-amd" "r8169" ];
    extraModulePackages = [ ];
    
    # Set Kernel Parameters
    kernelParams = [
      # Disable AMDGPU 
      #"nomodeset" 
      "zswap.enabled=1"
      "zswap.compresor=lz4"
      "zswap.max_pool_percent=20"
    ];
  };
}
