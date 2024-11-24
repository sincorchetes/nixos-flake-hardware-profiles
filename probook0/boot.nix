{ config, pkgs, ... }:

{
  boot = {

   blacklistedKernelModules = [ "amdgpu" "nouveau"];

    # RAM Image Kernel Modules

    initrd = {
      luks.devices."nixos-root".device = "/dev/disk/by-uuid/67c0f096-ab39-40b4-9187-8cc6f3cbee24";
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "uas" "ahci" "thunderbolt" "usbhid"];
    };

    # Set Kernel Modules
    
    kernelModules = [ "kvm-amd" "r8169" ];
    extraModulePackages = [ pkgs.vmware-workstation ];
    
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
