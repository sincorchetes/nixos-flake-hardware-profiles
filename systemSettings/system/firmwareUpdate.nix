{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       fwupd
       fwupd-efi
    ];
  };
}
