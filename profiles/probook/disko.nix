{
  disko.devices = {
    zpool = {
      rpool = {
        type = "zpool";
        device = "/dev/disk/by-partlabel/nixos-partition"; 
        
        rootFsOptions = {
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          keylocation = "prompt";
          compression = "zstd";
          atime = "off";
        };
        datasets = {
          "local/root" = { type = "zfs_fs"; mountpoint = "/"; };
          "local/nix"  = { type = "zfs_fs"; mountpoint = "/nix"; options.atime = "off"; };
          "safe/home"  = { type = "zfs_fs"; mountpoint = "/home"; };
        };
      };
    };
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/AB3C-BDD1";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };
}