{
  disko.devices = {
    zpool.rpool = {
      type = "zpool";
      datasets = {
        "local/root" = {
          type = "zfs_fs";
          mountpoint = "/";
          options.mountpoint = "legacy";
        };
        "local/nix" = {
          type = "zfs_fs";
          mountpoint = "/nix";
          options.mountpoint = "legacy";
        };
        "local/vms" = {
          type = "zfs_fs";
          mountpoint = "/var/lib/libvirt/images";
          options.mountpoint = "legacy";
        };
        "local/docker" = {
          type = "zfs_fs";
          mountpoint = "/var/lib/docker";
          options.mountpoint = "legacy";
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
          options.mountpoint = "legacy";
        };
      };
    };
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/00BB-E2E2";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" "defaults" ];
  };
}
