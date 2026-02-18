{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {};
      };
    };

    zpool = {
      rpool = {
        type = "zpool";
        mode = "/dev/disk/by-partlabel/nixos-zfs";
        
        options = {
          ashift = "12";
          autotrim = "on";
        };

        rootFsOptions = {
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          keylocation = "prompt";
          compression = "lz4";
          xattr = "sa";
          atime = "off";
          acltype = "posixacl";
        };

        datasets = {
          "local/root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options.mountpoint = "legacy";
          };
          "local/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options = {
              atime = "off";
              mountpoint = "legacy";
            };
          };
          "local/vms" = {
            type = "zfs_fs";
            mountpoint = "/var/lib/libvirt/images";
            options = {
              mountpoint = "legacy";
              recordsize = "64K";
              "com.sun:auto-snapshot" = "false";
            };
          };
          "local/docker" = {
            type = "zfs_fs";
            mountpoint = "/var/lib/docker";
            options = {
              mountpoint = "legacy";
              recordsize = "128K";
            };
          };
          "safe/home" = {
            type = "zfs_fs";
            mountpoint = "/home";
            options.mountpoint = "legacy";
          };
          "safe/home/sincorchetes" = {
            type = "zfs_fs";
            mountpoint = "/home/sincorchetes";
            options.mountpoint = "legacy";
          };
          "safe/home/sincorchetes/.cache" = {
            type = "zfs_fs";
            mountpoint = "/home/sincorchetes/.cache";
            options = {
              mountpoint = "legacy";
              atime = "off";
              "com.sun:auto-snapshot" = "false";
            };
          };
          "safe/home/sincorchetes/.local" = {
            type = "zfs_fs";
            mountpoint = "/home/sincorchetes/.local";
            options.mountpoint = "legacy";
          };
        };
      };
    };
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9EAB-2D57";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" "defaults" ];
  };
}
