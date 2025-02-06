{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       bridge-utils
       inetutils
    ];
  };
}
