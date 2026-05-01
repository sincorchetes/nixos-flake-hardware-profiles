{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./disko.nix
    ../../modules
    ../../modules/hardware/nvidia.nix
    ../../modules/hardware/bluetooth.nix
    ../../modules/services/steam.nix
    ../../modules/system/llm.nix
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
      "amd_pstate=active"
      "amd_pstate.shared_mem=1"
      "preempt=full"
      "iommu=pt"
      "kvm_amd.avic=1"
      "usbcore.autosuspend=-1"
      "acpi_osi=\"!Windows 2020\""
      "zfs.zfs_arc_max=17179869184"
      "transparent_hugepage=madvise"
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

  services.udev.extraRules = ''
    # NVMe: use none scheduler (hardware has its own queue)
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"
  '';

  powerManagement.cpuFreqGovernor = "schedutil";

  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
  };

  powerManagement.powerDownCommands = ''
    ${pkgs.kmod}/bin/modprobe -r btusb
  '';
  powerManagement.resumeCommands = ''
    ${pkgs.kmod}/bin/modprobe btusb
  '';



  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
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
