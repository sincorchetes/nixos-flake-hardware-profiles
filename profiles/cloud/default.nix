{ lib, pkgs, ... }:

{
  imports = [
    ./disko.nix
    ../../modules
    ../../modules/system/secureboot.nix
    ../../modules/hardware/intel-gpu.nix
    ../../modules/hardware/bluetooth.nix
    ../../modules/services/steam.nix
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
      "zswap.zpool=zsmalloc"
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

    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%";
    };
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.dirty_background_ratio" = 5;
    "vm.dirty_ratio" = 15;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_writeback_centisecs" = 1500;
    "vm.dirty_expire_centisecs" = 3000;
    "vm.page-cluster" = 0;
    "fs.inotify.max_user_watches" = 524288;
    "fs.inotify.max_user_instances" = 1024;
    "fs.file-max" = 2097152;
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
  # Disabled: powertop --auto-tune forces aggressive PCIe/NVMe runtime PM,
  # which was causing "nvme0: I/O tag ... timeout, completion polled" every
  # ~30s during boot (the controller couldn't wake from the deeper power
  # state in time), adding minutes to boot.
  powerManagement.powertop.enable = false;

  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="nvme[0-9]*n[0-9]*", ATTR{queue/scheduler}="none"
    ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="dm-[0-9]*", ATTR{bdi/read_ahead_kb}="2048"
  '';

  environment.systemPackages = with pkgs; [
    powertop
  ];

  virtualisation.docker = {
    enable = true;
    storageDriver = "overlay2";
  };
}
