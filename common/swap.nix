{ config, pkgs, lib, ... }:

{

  swapDevices = lib.optionals (builtins.pathExists "/swapfile") [
    {
      file = "/swapfile";   # Ubicación del swapfile
      size = 4096;          # Tamaño del swap en MiB (por ejemplo, 4 GiB)
      options = [ "discard" ]; # Opciones adicionales (opcional)
    }
  ];
}