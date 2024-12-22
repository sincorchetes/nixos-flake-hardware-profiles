{ config, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a53dd61d-744a-480f-ac76-07f81a605ed1";
      fsType = "ext4";
      options = [ "discard" "noatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/48F8-6B1C";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

}
