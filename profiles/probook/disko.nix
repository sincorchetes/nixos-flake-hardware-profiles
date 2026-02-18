{
  disko.devices = {
    zpool = {
      rpool = {
        type = "zpool";
        
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
          "local/root" = { 
            type = "zfs_fs"; 
            mountpoint = "/"; 
            options.mountpoint = "legacy"; 
          };
          "local/nix" = { 
            type = "zfs_fs"; 
            mountpoint = "/nix"; 
            options = { mountpoint = "legacy"; atime = "off"; }; 
          };
          "local/vms" = { 
            type = "zfs_fs"; 
            mountpoint = "/var/lib/libvirt/images"; # Ruta estándar
            options = { mountpoint = "legacy"; atime = "off"; }; 
          };
          "local/docker" = { 
            type = "zfs_fs"; 
            mountpoint = "/var/lib/docker"; 
            options = { mountpoint = "legacy"; atime = "off"; }; 
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
            options = { mountpoint = "legacy"; atime = "off"; }; 
          };
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
