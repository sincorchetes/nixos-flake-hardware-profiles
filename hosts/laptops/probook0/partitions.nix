{
  fileSystems = {
    "/" = { 
      device = "/dev/disk/by-uuid/bc7203e8-778e-462a-a1d1-6badb1508085";
      fsType = "ext4";
      options = [ "noatime" ];
    };

    "/boot" = { 
      device = "/dev/disk/by-uuid/0932-D6AA";
      fsType = "vfat";
      options = [ "noauto" ];
    };
  };
}
