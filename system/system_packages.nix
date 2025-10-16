{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi lm_sensors pciutils inetutils lshw usbutils vdpauinfo kernelshark mesa binutils gnupg unzip       # System Tools
    borgbackup openssl git                                                                                 # System Tools
    tcpdump nmap p0f wireshark rustscan                                                                    # Network Security Tools
    pritunl-client openfortivpn                                                                            # VPN Software
    sops age cachix devenv                                                                                 # NixOS Management Software Tools
    gnomeExtensions.pop-shell gnomeExtensions.easyeffects-preset-selector gnomeExtensions.appindicator     # GNOME Extensions
  ];

  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    nerd-fonts.ubuntu-sans
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono
    roboto
    font-awesome
    noto-fonts-emoji-blob-bin
    powerline-fonts
  ];
}
