{ pkgs, ... }:

{
  imports = [
    ./disko.nix
    ../modules/hardware/intel-gpu.nix
    ../modules/hardware/bluetooth.nix
    ../modules/system/network.nix
    ../modules/system/vpn.nix
    ../modules/system/security.nix
    ../modules/system/users.nix
    ../modules/system/core.nix
  ];

  networking.hostName = "probook0";
  networking.networkmanager.wifi.powersave = true;

  services.thermald.enable = true;
  services.power-profiles-daemon.enable = true;

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    firmware = with pkgs; [ sof-firmware linux-firmware ];
    bluetooth.enable = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    zfs.devNodes = "/dev/disk/by-path";
    supportedFilesystems = [ "ntfs" "zfs" ];

    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      "i915.enable_psr=0"
      "intel_iommu=on"
      "zswap.enabled=1"
      "zswap.max_pool_percent=15"
    ];
  };
}