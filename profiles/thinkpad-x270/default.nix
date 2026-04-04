{ pkgs, ... }:

{
  imports = [
    ./disko.nix
    ../../modules/system/base.nix
    ../../modules/system/users.nix
    ../../modules/system/network.nix
    ../../modules/system/security.nix
    ../../modules/services/xfce.nix
    ../../modules/hardware/intel-gpu.nix
    ../../modules/hardware/bluetooth.nix
  ];

  networking = {
    hostName = "thinkpad-x270";
    hostId = "a1b2c3d4";
    networkmanager.wifi.powersave = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  nixpkgs.config = {
    allowBroken = true;
  };

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

    kernelPackages = pkgs.linuxPackages_6_1;
    extraModulePackages = with pkgs.linuxPackages_6_1; [
      rtl8812au
    ];

    kernelParams = [
      "intel_pstate=powersave"
      "i915.enable_psr=1"
      "zswap.enabled=1"
      "zswap.max_pool_percent=10"
      "zswap.compressor=lz4"
    ];
  };
}
