{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/nvme0n1"; # Ajustar según tu hardware real [cite: 21]
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
              mountOptions = [ "fmask=0022" "dmask=0022" ]; # Consistencia con tu imagen anterior
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
        keylocation = "prompt"; # Solicita clave en el arranque para máxima seguridad [cite: 54, 84, 86]
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
        # Replicando el comportamiento NOCOW para VMs
        "local/vms" = {
          type = "zfs_fs";
          mountpoint = "/var/lib/libvirt/images";
          options = {
            mountpoint = "legacy";
            recordsize = "64K"; # Optimización para imágenes de disco QCOW2 [cite: 88]
            "com.sun:auto-snapshot" = "false";
          };
        };
        # Replicando el comportamiento NOCOW para Docker
        "local/docker" = {
          type = "zfs_fs";
          mountpoint = "/var/lib/docker";
          options = {
            mountpoint = "legacy";
            recordsize = "128K"; # Estándar para el backend de almacenamiento ZFS de Docker [cite: 12, 34]
          };
        };
        "safe/home" = {
          type = "zfs_fs";
          mountpoint = "/home";
          options.mountpoint = "legacy";
        };
        # Dataset independiente para caché (mantiene snapshots limpios)
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
