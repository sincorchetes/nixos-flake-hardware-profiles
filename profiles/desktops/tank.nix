{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    ../../system/importer.nix
  ];

  hardware = {
    cpu.amd.updateMicrocode = true;
    xpadneo.enable = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "590.44.01";
        
        sha256_64bit = "sha256-VbkVaKwElaazojfxkHnz/nN/5olk13ezkw/EQjhKPms=";
        sha256_aarch64 = "sha256-gpqz07aFx+lBBOGPMCkbl5X8KBMPwDqsS+knPHpL/5g=";
        openSha256 = "sha256-ft8FEnBotC9Bl+o4vQA1rWFuRe7gviD/j1B8t0MRL/o=";
        settingsSha256 = "sha256-wVf1hku1l5OACiBeIePUMeZTWDQ4ueNvIk6BsW/RmF4=";
        persistencedSha256 = "sha256-nHzD32EN77PG75hH9W8ArjKNY/7KY6kPKSAhxAWcuS4=";
      };
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = true;
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

  services.xserver.videoDrivers = [ "nvidia" ];

  programs.steam.enable = true;

  nix = {
    settings = {
      cores = 12;
      max-jobs = 1;
    };
  };

  networking.hostName = "tank0";

  environment = {

    systemPackages = with pkgs; [
      microcode-amd
    ];
  };

  boot = {
    blacklistedKernelModules = [ "nouveau" "amdgpu" ];
    kernelModules = [ "hid_logitech_dj" "hid_logitech_hidpp" ];
    

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
      "preempt=full"
      "usbcore.autosuspend=-1"
      "iommu=pt"
      "nvidia-drm.modeset=1"
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
