{ config, pkgs, lib, ... }:
{
    hardware.cpu.amd.updateMicrocode = true;

    environment = {
        systemPackages = with pkgs; [
            microcodeAmd
        ];
    };
}