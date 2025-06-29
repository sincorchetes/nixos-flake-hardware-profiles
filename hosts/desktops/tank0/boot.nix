{ config, pkgs, ... }:


{
  boot = {

   blacklistedKernelModules = [ "amdgpu" "nouveau" "kvm-amd"];
   # Trying USB BT
   #blacklistedKernelModules = [ "amdgpu" "nouveau" "bluetooth" "btusb" "kvm-amd"];
    # RAM Image Kernel Modules

    initrd = {
      availableKernelModules = [ 
        "xhci_pci" 
        "nvme" 
        "usb_storage" 
        "sd_mod" 
        "uas" 
        "ahci" 
      ];
      luks.devices."nixos-root".device = "/dev/disk/by-uuid/4abffc3b-0780-47cd-8b91-376e068caf4a";
    };

    # Set Kernel Modules
    kernelModules = [ 
      #"kvm-amd" 
      "r8169" 
      "thunderbolt" 
      "usbhid"
      #"btusb"
      #"bluetooth"
      #"btrtl"
      #"btintel"
      #"btbcm"
      #"btmtk"
    ];

    extraModulePackages = [ ];
    
    kernel.sysctl = {
      "vm.swappiness" = 10;
    };
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
