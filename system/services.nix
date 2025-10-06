{ pkgs, ... }:

{
  systemd = {
    packages = [ pkgs.pritunl-client ];
    services.NetworkManager-wait-online.enable = false;
    targets.multi-user.wants = [ "pritunl-client.service" ];
  };

  services = {
    thermald.enable = true;
    fstrim.enable = true;
    dbus.apparmor = "enabled";
    powerManagement.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };

    xserver = {
      enable = true;
      xkb.layout = "es";
      libinput = {
        enable = true;
        touchpad.tapping = true;
      };
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager.gnome.enable = true;
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

    # ollama = {
    #   enable = true;
    #   acceleration = "cuda";
    #   package = pkgsUnstable.ollama-cuda;
    # };
  };
}