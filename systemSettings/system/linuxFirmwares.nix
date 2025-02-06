{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       linux-firmware
    ];
  };
}

