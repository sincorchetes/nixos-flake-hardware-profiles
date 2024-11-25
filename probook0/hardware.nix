{ config, lib, pkgs, ... }:
{
    hardware = {
        firmware = [ pkgs.soft-firmware ];
    };
}
