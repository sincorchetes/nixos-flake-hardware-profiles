{ pkgs, ... }:

{
  imports = [
    ./disko.nix
    ../../modules
    ../../modules/system/secureboot.nix
    ../../modules/hardware/intel-gpu.nix
    ../../modules/hardware/bluetooth.nix
  ];

  networking = {
    hostName = "cloud0";
    hostId = "26c607d9";
    networkmanager.wifi.powersave = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = true;
      grub.enable = false;
    };

    kernelPackages = pkgs.linuxPackages_6_18;
    zfs.package = pkgs.zfs_2_4;
    zfs.forceImportRoot = true;
    zfs.devNodes = "/dev/disk/by-partlabel";
    zfs.requestEncryptionCredentials = true;

    kernelParams = [
      "intel_pstate=active"
      "i915.enable_psr=0"
      "intel_iommu=on"
      "zswap.enabled=1"
      "zswap.max_pool_percent=15"
      "zswap.compressor=zstd"
      "zfs.zfs_arc_max=4294967296"
    ];

    initrd = {
      supportedFilesystems = [ "zfs" ];
      availableKernelModules = [
        "vmd"
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
        "thunderbolt"
        "intel_lpss_pci"
      ];
      includeDefaultModules = true;
    };

    supportedFilesystems = [ "zfs" "ntfs" ];
    kernelModules = [ "kvm-intel" ];
  };

  services.thermald.enable = true;
  services.power-profiles-daemon.enable = true;

  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"
  '';

  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
  };

  services.sanoid = {
    enable = true;
    datasets = {
      "rpool/safe/home" = {
        autoprune = true;
        autosnap = true;
        hourly = 24;
        daily = 7;
        monthly = 3;
      };
      "rpool/local/root" = {
        autoprune = true;
        autosnap = true;
        hourly = 12;
        daily = 3;
        monthly = 1;
      };
    };
  };
}
