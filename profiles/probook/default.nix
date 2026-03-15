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
    ../../modules/services/default.nix
  ];

  networking = {
    hostName = "probook0";
    hostId = "8425af91";
    networkmanager.wifi.powersave = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    cpu.intel.updateMicrocode = true;
    xpadneo.enable = true;
    enableRedistributableFirmware = true;
    firmware = with pkgs; [
      sof-firmware
      linux-firmware
    ];
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

    kernelParams = [
      "intel_pstate=active"
      "i915.enable_psr=1"
      "intel_iommu=on"
      "zswap.enabled=1"
      "zswap.max_pool_percent=15"
      "zswap.compressor=zstd"
      "zfs.zfs_arc_max=8589934592"
    ];

    initrd = {
      supportedFilesystems = [ "zfs" ];
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
        "intel_lpss_pci"
        "i915"
        "thunderbolt"
      ];
      includeDefaultModules = true;
    };

    zfs.devNodes = "/dev/disk/by-partlabel";
    zfs.forceImportRoot = true;
    supportedFilesystems = [
      "ntfs"
      "zfs"
    ];
    kernelModules = [ "kvm-intel" ];
  };

  services.thermald.enable = true;
  services.power-profiles-daemon.enable = true;

  services.udev.extraRules = ''
    # NVMe: use none scheduler (hardware has its own queue)
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"
  '';

  environment.systemPackages = with pkgs; [
    powertop
  ];

  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
