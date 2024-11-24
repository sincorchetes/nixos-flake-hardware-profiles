{
  fileSystems = {
    "/" = { 
      device = "/dev/disk/by-uuid/5f9735d5-3a5d-479b-bfd2-d5d82306f1b8";
      fsType = "ext4";
      options = [ "discard" "noatime" ];
    };

    "/boot" = { 
      device = "/dev/disk/by-uuid/491C-906D";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  };
}