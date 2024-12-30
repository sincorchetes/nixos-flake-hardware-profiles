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
      ./../common/hardware.nix
      ./../common/swap.nix
      ./../common/wayland.nix

      # Custom Platform
      ./boot.nix
      ./partitions.nix
      ./amd.nix
      ./network.nix
      ./nvidia.nix
      ./gaming.nix
    ];
}
