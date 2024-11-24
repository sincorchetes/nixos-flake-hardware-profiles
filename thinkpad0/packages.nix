{ config, lib, pkgs, ... }:

{
  # System Packages Default Will Be Installed
  environment = {
    systemPackages = with pkgs; [
       microcodeIntel
       iucode-tool
    ];
  };
}
