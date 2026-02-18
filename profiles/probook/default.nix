{ pkgs, ... }:

{
  imports = [
    ./disko.nix
    ../../modules/hardware/intel-gpu.nix
    ../../modules/hardware/bluetooth.nix
    ../../modules/system/network.nix
    ../../modules/system/vpn.nix
    ../../modules/system/security.nix
    ../../modules/system/users.nix
    ../../modules/system/core.nix
  ];

  networking = {
    hostName = "probook0";
    hostId = "8425af91"; 
    networkmanager.wifi.powersave = true;
  };
  
  nixpkgs.hostPlatform = "x86_64-linux";
  
  services.thermald.enable = true;
  services.power-profiles-daemon.enable = true;

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    firmware = with pkgs; [ sof-firmware linux-firmware ];
  };

  boot = {
    loader = { 
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot"; 
      };
      grub.enable = false;
    };
    
    zfs.devNodes = "/dev/disk/by-partlabel"; 
    supportedFilesystems = [ "ntfs" "zfs" ];

    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      "i915.enable_psr=1"
      "intel_iommu=on"
      "zswap.enabled=1"
      "zswap.max_pool_percent=15"
      "nvme_core.default_ps_max_latency_us=0" 
    ];
    
    initrd.supportedFilesystems = [ "zfs" "nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
    initrd.includeDefaultModules = false;
  };
}
