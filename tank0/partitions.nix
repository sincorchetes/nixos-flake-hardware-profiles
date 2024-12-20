{ config, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/043eb0d2-8124-4dcc-9404-dda4c9c79800";
      fsType = "ext4";
      options = [ "discard" "noatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/AA04-70EC";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

}
