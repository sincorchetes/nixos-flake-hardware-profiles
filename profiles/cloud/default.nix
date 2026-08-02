{ lib, pkgs, ... }:

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
      efi.efiSysMountPoint = "/boot/EFI";
      grub.enable = false;
    };

    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "intel_pstate=active"
      "i915.enable_psr=0"
      "i915.enable_fbc=1"
      "intel_iommu=on"
      "zswap.enabled=1"
      "zswap.max_pool_percent=15"
      "zswap.compressor=zstd"
      "zswap.zpool=z3fold"
      "mem_sleep_default=deep"
      "nmi_watchdog=0"
    ];

    initrd = {
      systemd.enable = true;
      luks.devices."cryptroot" = lib.mkForce {
        device = "/dev/disk/by-partlabel/cryptdisk";
        allowDiscards = true;
        bypassWorkqueues = true;
      };
      kernelModules = [
        "vmd"
        "nvme"
        "dm_mod"
        "dm_crypt"
      ];
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
        "thunderbolt"
        "intel_lpss_pci"
      ];
      includeDefaultModules = true;
    };

    supportedFilesystems = [ "ntfs" ];
    kernelModules = [ "kvm-intel" ];
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.dirty_background_ratio" = 5;
    "vm.dirty_ratio" = 15;
    "vm.vfs_cache_pressure" = 50;
    "net.core.rmem_max" = 134217728;
    "net.core.wmem_max" = 134217728;
    "net.ipv4.tcp_rmem" = "4096 87380 134217728";
    "net.ipv4.tcp_wmem" = "4096 65536 134217728";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "fq";
  };

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  services.irqbalance.enable = true;
  services.thermald.enable = true;
  services.power-profiles-daemon.enable = true;
  powerManagement.powertop.enable = true;

  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"
  '';

  environment.systemPackages = with pkgs; [
    powertop
  ];

  virtualisation.docker = {
    enable = true;
    storageDriver = "overlay2";
  };
}
