{

  # Partition scheme
  fileSystems = {

    # Root Partition
    "/" = { 
      device = "/dev/disk/by-uuid/b0057114-32f4-4c3b-96ac-ad121ff86061";
      fsType = "ext4";
      options = [ "discard" "noatime" ];
    };

    # Boot Partition
    "/boot" = { 
      device = "/dev/disk/by-uuid/B954-78FE";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  };
}
