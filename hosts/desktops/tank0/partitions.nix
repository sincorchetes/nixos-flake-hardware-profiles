{ config, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/3c22d709-626b-4706-acaf-8c2b48ce0769";
      fsType = "ext4";
      options = [ "discard" "noatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8F44-F4B3";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

}
