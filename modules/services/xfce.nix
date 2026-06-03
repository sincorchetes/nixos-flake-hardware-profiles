{ pkgs, ... }:
{
  systemd.services.NetworkManager-wait-online.enable = false;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
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
      desktopManager = {
        xfce = {
            enable = true;
            enableWaylandSession = true;
            enableXfwm = false;
        };
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
      sddm = {
        enable = true;
        wayland.enable = true;
      };
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

  environment.sessionVariables = {
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
