{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "fmask=0022" "dmask=0022" ];
            };
          };
          zfs = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "rpool";
            };
          };
        };
      };
    };
    zpool.rpool = {
      type = "zpool";
      options.ashift = "12";
      rootFsOptions = {
        encryption = "aes-256-gcm";
        keyformat = "passphrase";
        keylocation = "prompt";
        compression = "lz4";
        xattr = "sa";
        atime = "off";
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
        "safe/home/sincorchetes/.cache" = {
          type = "zfs_fs";
          mountpoint = "/home/sincorchetes/.cache";
          options = {
            mountpoint = "legacy";
            atime = "off";
          };
        };
      };
    };
  };
}
