{ config, pkgs, ... }:
{
  imports =
    [ 
      # Common files
      ./../common/boot.nix
      ./../common/language.nix
      ./../common/services.nix
      ./../common/system.nix
      ./../common/packages.nix
      ./../common/users.nix
      ./../common/programs.nix
      ./../common/network.nix
      ./../common/intel.nix
      ./../common/hardware.nix
      ./../common/swap.nix

      # Custom Platform
      ./boot.nix
      ./partitions.nix
      ./network.nix
    ];
}
