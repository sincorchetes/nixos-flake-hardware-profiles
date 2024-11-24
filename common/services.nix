{ pkgs, ... }:

{
  
services = {

  teamviewer.enable = true;
  # Avoid TRIM issues in the future
  fstrim.enable = true;

  # OpenSSH Settings
  # openssh.enable = true;

  # Printer Settings
  printing = {
    enable = true;
    drivers = [ pkgs.brlaser ];
  };

  # Audio Settings
  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Disable Avahi Daemon
  avahi = {
    enable = false;
    nssmdns4 = false;
  };

  # Power Management
  thermald.enable = true;

  # X Server
  xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.wayland = true;
    xkb = {
      layout = "es";
      variant = "";
    };
  };

  # Enable Libinput
  libinput = {
    enable = true;
    touchpad = {
      tapping = true;
    };
  };
 };
}
