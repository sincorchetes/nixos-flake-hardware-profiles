{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi lm_sensors pciutils inetutils lshw usbutils vdpauinfo kernelshark mesa binutils        # System Tools
    uutils-coreutils-noprefix
    pritunl-client openfortivpn                                                                 # VPN Software
    cachix                                                                                      # NixOS Management Software Tools
  ];

}
