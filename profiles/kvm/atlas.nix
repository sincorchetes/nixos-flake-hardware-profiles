{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    ../../system/importer.nix
  ];

  hardware = {
    cpu.amd.updateMicrocode = true;
  };

  services = {
    spice-vdagentd.enable = true;
    qemuGuest.enable = true;
    xserver.videoDrivers = [ "modesetting" "fbdev" ];
    zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };
  };

  networking = {
    hostName = "atlas0";
    hostId = "F1A234E0";
  };

  environment = {

    systemPackages = with pkgs; [
      microcodeAmd
      glxinfo
      spice-vdagent
      spice-autorandr
      vulkan-tools
    ];
  };

  boot = {
    kernelParams = [
      "preempt=full"
    ];
    supportedFilesystems = [ "zfs" ];
    initrd = {
      supportedFilesystems = [ "zfs" ];
      kernelModules = [ "zfs" ];
    };
  };

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512MiB";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "nofail" ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };

    zpool = {
      zroot = {
        type = "zpool";
        rootFsOptions = {
          mountpoint = "none";
          compression = "zstd";
          acltype = "posixacl";
          xattr = "sa";
          "com.sun:auto-snapshot" = "true";
        };
        options.ashift = "12";

        datasets = {
          "root" = {
            type = "zfs_fs";
            options = {
              encryption = "aes-256-gcm";
              keyformat = "passphrase";
              keylocation = "prompt";
            };
            mountpoint = "/";
          };
        };
      };
    };
  };
}
