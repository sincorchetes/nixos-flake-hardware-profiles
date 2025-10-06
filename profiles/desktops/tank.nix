{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    "../../system/importer.nix"
  ];

  hardware = {
    cpu.amd.updateMicrocode = true;
    xpadneo.enable = true;
    nvidia = {
      package = pkgs.linuxPackages_zen.nvidia_x11_latest;
      #package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #  version = "570.86.16"; # use new 570 drivers
      #  sha256_64bit = "sha256-RWPqS7ZUJH9JEAWlfHLGdqrNlavhaR1xMyzs8lJhy9U=";
      #  openSha256 = "sha256-DuVNA63+pJ8IB7Tw2gM4HbwlOh1bcDg2AN2mbEU9VPE=";
      #  settingsSha256 = "sha256-9rtqh64TyhDF5fFAYiWl3oDHzKJqyOW3abpcf2iNRT8=";
      #  usePersistenced = false;
      #};
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
    };
  };

  systemd = {
    sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
      AllowHybridSleep=no
      AllowSuspendThenHibernate=no
    '';
  };

  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  programs.steam = {
    enable = true;
  };

  nix = {
    settings = {
      cores = 12;
      max-jobs = 1;
    };
  };

  networking.hostName = "tank0";

  environment = {
    systemPackages = with pkgs; [
      microcodeAmd
    ];
  };

  boot = {
    blacklistedKernelModules = [ "amdgpu" "nouveau" ];
    # Trying USB BT
    #blacklistedKernelModules = [ "amdgpu" "nouveau" "bluetooth" "btusb" "kvm-amd"];

    initrd = {
      secrets."/vault.key" = "/etc/disk-keys/vault.key";
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
          keyFile = "/vault.key";
          allowDiscards = true;
        };
      };
    };

    kernel.sysctl = {
      "vm.swappiness" = 0;
    };

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

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/3c22d709-626b-4706-acaf-8c2b48ce0769";
    fsType = "ext4";
    options = [ "defaults" "noatime" "lazytime" "commit=60" "errors=remount-ro" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8F44-F4B3";
    fsType = "vfat";
    options = [ "noauto" ];
    #options = [ "fmask=0022" "dmask=0022" ];
  };

  fileSystems."/home/sincorchetes/Vault" = {
    device = "/dev/mapper/vault";
    fsType = "ext4";
    options = [ "defaults" "noatime" "lazytime" "commit=60" "errors=remount-ro" ];
  };
}