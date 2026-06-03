{
  disko.devices = {
    zpool.rpool = {
      type = "zpool";
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
            "com.sun:auto-snapshot" = "false";
          };
        };
      };
    };
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A21B-C51C";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
      "defaults"
    ];
  };
}
