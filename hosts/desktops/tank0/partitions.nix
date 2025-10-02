{ config, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/3c22d709-626b-4706-acaf-8c2b48ce0769";
      fsType = "ext4";
      options = [ "noatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8F44-F4B3";
      fsType = "vfat";
      options = [ "noauto" ];
      #options = [ "fmask=0022" "dmask=0022" ];
    };
  fileSystems."/home/sincorchetes/Vault" = {
    device = "/dev/mapper/vault";
    fsType = "ext4";
    options = [ "defaults" "noatime" "lazytime" "commit=60" "errors=remount-ro" ];
  };

}
