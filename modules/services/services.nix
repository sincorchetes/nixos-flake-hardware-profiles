{ pkgs, ... }:

{
  systemd.services.NetworkManager-wait-online.enable = false; 

  services = {
    speechd.enable = false;
    orca.enable = false;
    
    dbus.apparmor = "enabled"; 

    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };

    libinput = {
      enable = true;
      touchpad.tapping = true;
    };

    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    avahi = {
      enable = false;
      nssmdns4 = false;
    };
  };
}