{
  disko.devices = {
    zpool = {
      zroot = {
        type = "zpool";
        device = "/dev/disk/by-partlabel/nixos-zfs"; 
        
        rootFsOptions = {
          acltype = "posixacl";
          canmount = "off";
          compression = "zstd";
          dnodesize = "auto";
          normalization = "formD";
          relatime = "on";
          xattr = "sa";
          mountpoint = "none";
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          keylocation = "prompt";
        };

        datasets = {
          "local/root" = { type = "zfs_fs"; mountpoint = "/"; };
          "local/nix"  = { type = "zfs_fs"; mountpoint = "/nix"; options.atime = "off"; };
          "safe/home"  = { type = "zfs_fs"; mountpoint = "/home"; };
          "safe/persist" = { type = "zfs_fs"; mountpoint = "/persist"; };
        };
      };
    };
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9EAB-2D57";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };
}
