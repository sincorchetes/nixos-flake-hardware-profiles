{ pkgs, ... }:
{
  systemd.services.NetworkManager-wait-online.enable = false;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-cosmic
    ];
    config = {
      cosmic.default = [
        "cosmic"
        "gtk"
      ];
      gnome.default = [
        "gnome"
        "gtk"
      ];
      common.default = [
        "gtk"
      ];
    };
  };

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
    dbus = {
      enable = true;
      apparmor = "disabled";
    };

    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };

    libinput = {
      enable = true;
      touchpad.tapping = true;
    };

    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
      #cosmic-greeter.enable = true;
    };

    desktopManager = {
      gnome = {
        enable = true;
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
          experimental-features=['scale-monitor-framebuffer']
        '';
      };
      cosmic.enable = true;

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
