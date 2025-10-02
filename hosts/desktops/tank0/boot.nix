{
  boot = {

   blacklistedKernelModules = [ "amdgpu" "nouveau"];
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
      luks.devices = {
        "nixos-root" = {
          device = "/dev/disk/by-uuid/4abffc3b-0780-47cd-8b91-376e068caf4a";
          allowDiscards = true;
        };
        "vault" = {
          device = "/dev/disk/by-uuid/82c3329f-fa66-4c03-a46e-aa37a8e7e80c";
          keyFile = "/etc/disk-keys/vault.key";
          dependsOn = [ "nixos-root" ];
          allowDiscards = true;
        };
      };
    };

    # Set Kernel Modules
    #kernelModules = [
    #];

    #extraModulePackages = [ ];
    
    kernel.sysctl = {
      "vm.swappiness" = 0;
    };
    # Set Kernel Parameters
    kernelParams = [
      # Enable full preempt.
      "preempt=full"
      # Disable AMDGPU 
      #"nomodeset" 
      # Disabling zswap, I don't suspend the host.
      #"zswap.enabled=1"
      #"zswap.compresor=lz4"
      #"zswap.max_pool_percent=20"
    ];
  };
}
