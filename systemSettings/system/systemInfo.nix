{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       pciutils
       inetutils
       lshw
       usbutils
       vdpauinfo
       lm_sensors
       ncdu
       hping
       fastfetch
       acpi
    ];
  };
}
