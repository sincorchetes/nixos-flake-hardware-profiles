{ config, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1408f194-89ea-44fd-8eff-cac5fe6e2519";
      fsType = "ext4";
      options = [ "discard" "noatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/30B8-7234";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

}
