{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    ../../system/importer.nix
  ];

  hardware = {
    cpu.amd.updateMicrocode = true;
    xpadneo.enable = true;
    nvidia = {
      package = pkgs.linuxPackages_zen.nvidia_x11_latest;
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      prime = {
            offload.enable = true;
            amdgpuBusId = "PCI:73:0:0";
            nvidiaBusId = "PCI:1:0:0";
      };
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

  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

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
      microcodeAmd
      glxinfo
      vulkan-tools
      (writeShellScriptBin "nvidia-offload" ''
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __VK_LAYER_NV_optimus=NVIDIA_only
        exec "$@"
      '')
      
      (writeShellScriptBin "prime-run" ''
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __VK_LAYER_NV_optimus=NVIDIA_only
        exec "$@"
      '')
    ];
  };

  boot = {
    blacklistedKernelModules = [ "nouveau" ];
    # Trying USB BT
    #blacklistedKernelModules = [ "amdgpu" "nouveau" "bluetooth" "btusb" "kvm-amd"];
    extraModprobeConfig = "options hid_logitech_hidpp disable_raw_hid=1";

    initrd = {
      secrets."/vault.key" = "/etc/disk-keys/vault.key";
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "sd_mod"
        "uas"
        "ahci"
        "amdgpu"
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
