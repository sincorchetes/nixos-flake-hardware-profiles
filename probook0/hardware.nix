{ config, lib, pkgs, ... }:
{
    hardware = {
        firmware = [ pkgs.sof-firmware ];
    };
}
