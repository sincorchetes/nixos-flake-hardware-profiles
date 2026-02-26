{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./disko.nix
    ../../modules/hardware/nvidia.nix
    ../../modules/hardware/bluetooth.nix
    ../../modules/system/network.nix
    ../../modules/system/vpn.nix
    ../../modules/system/security.nix
    ../../modules/system/users.nix
    ../../modules/system/core.nix
    ../../modules/services/default.nix
  ];

  networking = {
    hostName = "tank0";
    hostId = "a50eaf91";
    networkmanager.wifi.powersave = false;
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware = {
    cpu.amd.updateMicrocode = true;
    xpadneo.enable = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.enable = false;
    };

    kernelPackages = pkgs.linuxPackages_6_18;
    zfs.package = pkgs.zfs_2_4;
    kernelParams = [
      "preempt=full"
      "iommu=pt"
      "kvm_amd.avic=1"
      "usbcore.autosuspend=-1"
      "acpi_osi=\"!Windows 2020\""
      "zfs.zfs_arc_max=17179869184"
    ];
    initrd.availableKernelModules = [
      "xhci_pci"
      "nvme"
      "usb_storage"
      "sd_mod"
      "uas"
      "ahci"
    ];
    blacklistedKernelModules = [
      "nouveau"
      "amdgpu"
    ];
  };

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
