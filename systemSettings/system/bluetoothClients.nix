{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       bluez
       bluez-tools
    ];
  };
}
