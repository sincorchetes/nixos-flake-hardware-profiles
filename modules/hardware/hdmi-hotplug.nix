{ pkgs, ... }:

let
  hdmi-reprobe = pkgs.writeShellScriptBin "hdmi-reprobe" ''
    # Force DRM reprobe on all HDMI connectors
    # Simulates the effect of physically unplugging/replugging the HDMI cable
    echo "Forcing DRM reprobe on HDMI connectors..."
    for connector in /sys/class/drm/card*-HDMI-*; do
      if [ -e "$connector/status" ]; then
        name=$(basename "$connector")
        echo "Reprobing $name..."
        echo "detect" | ${pkgs.coreutils}/bin/tee "$connector/status" > /dev/null 2>&1 || true
      fi
    done

    # Give the kernel a moment to process
    sleep 1

    # Trigger a uevent to notify userspace (compositor) of the change
    for connector in /sys/class/drm/card*-HDMI-*; do
      if [ -e "$connector/uevent" ]; then
        echo "change" | ${pkgs.coreutils}/bin/tee "$connector/uevent" > /dev/null 2>&1 || true
      fi
    done

    echo "Done. HDMI connectors reprobed."
  '';

  hdmi-hotplug-handler = pkgs.writeShellScript "hdmi-hotplug-handler" ''
    # Wait a moment for the signal to stabilize (projector powering on)
    sleep 2

    # Force reprobe on all HDMI connectors
    for connector in /sys/class/drm/card*-HDMI-*; do
      if [ -e "$connector/status" ]; then
        echo "detect" > "$connector/status" 2>/dev/null || true
      fi
    done

    sleep 1

    # Send uevent to notify compositors
    for connector in /sys/class/drm/card*-HDMI-*; do
      if [ -e "$connector/uevent" ]; then
        echo "change" > "$connector/uevent" 2>/dev/null || true
      fi
    done
  '';
in
{
  # Manual reprobe tool available system-wide
  environment.systemPackages = [ hdmi-reprobe ];

  # udev rule: when DRM subsystem reports a change, force reprobe
  services.udev.extraRules = ''
    # NVIDIA HDMI hotplug: force connector reprobe on state change
    ACTION=="change", SUBSYSTEM=="drm", KERNEL=="card[0-9]*", ENV{HOTPLUG}=="1", RUN+="${hdmi-hotplug-handler}"
  '';

  # Systemd service for manual or programmatic triggering
  systemd.services.hdmi-reprobe = {
    description = "Force HDMI DRM connector reprobe";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${hdmi-reprobe}/bin/hdmi-reprobe";
    };
  };

  # Systemd path unit: watch for DRM connector status changes as fallback
  systemd.paths.hdmi-monitor = {
    description = "Monitor HDMI connector status changes";
    wantedBy = [ "multi-user.target" ];
    pathConfig = {
      PathChanged = "/sys/class/drm/card1-HDMI-A-1/status";
      Unit = "hdmi-reprobe.service";
    };
  };
}
