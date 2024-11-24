{ pkgs, config, ... }:

{
    environment = {
        systemPackages = with pkgs; [
          soft-firmware
        ]
    }
}