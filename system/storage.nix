{ lib, ... }:

{
  swapDevices = lib.optionals (builtins.pathExists "/swapfile") [
    {
      file = "/swapfile";
      size = 4096;
      options = [ "discard" ];
    }
  ];
}