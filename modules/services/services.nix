{ pkgs, ... }: 
{
  systemd.services.NetworkManager-wait-online.enable = false; 

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "es";
        variant = "";
      };
    };
    speechd.enable = false;
    orca.enable = false;
    dbus.apparmor = "disabled"; 

    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };

    libinput = {
      enable = true;
      touchpad.tapping = true;
    };

    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
      '';
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      config.common.default = "gnome";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    pulseaudio.enable = false;
  };
}
