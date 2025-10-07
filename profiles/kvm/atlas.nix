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

  networking.hostName = "atlas0";

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
    disk.main = {
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

    zpool.zroot = {
      type = "zpool";
      options = {
        ashift = "12";
        autotrim = "on";
      };
      rootFsOptions = {
        compression = "zstd";
        atime = "off";
        xattr = "sa";
        acltype = "posixacl";
      };
      createOptions = [
        "-O" "encryption=on"
        "-O" "keyformat=passphrase"
        "-O" "mountpoint=/"
      ];
      datasets = {
        "root" = {
          type = "zfs_fs";
          mountpoint = "/";
        };
      };
    };
  };
}
