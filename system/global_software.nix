{ pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       geekbench
       kernelshark
       xdg-utils
      glib
      powerline-fonts
      roboto
      font-awesome
      noto-fonts-emoji-blob-bin
      desktop-file-utils
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
       nmap
      p0f
      tcpdump
      wireshark
      rustscan
      pritunl-client
       openfortivpn
       git 
      cachix 
      flat-remix-gnome
    flat-remix-icon-theme
    gnomeExtensions.pop-shell
    gnomeExtensions.easyeffects-preset-selector
    gnomeExtensions.appindicator
    ];
  };

  fonts = {
    packages = with pkgs; [
           nerd-fonts._0xproto
           nerd-fonts.droid-sans-mono
           nerd-fonts.ubuntu-sans
           nerd-fonts.ubuntu
           nerd-fonts.jetbrains-mono
         ];
  };
}
