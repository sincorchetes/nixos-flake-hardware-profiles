{ pkgs, ... }:

{
  # Services Section
  #services.dbus.apparmor = "enabled";

  # Security Section
  security = {

    # Disable sudo
    sudo.enable = true;

    # Enable AppArmor
    #apparmor = {
    #  enable = true;
    #};

    # Enable RealtimeKit for Pipewire
    rtkit.enable = true;

    # PAM Settings
    pam = {      
      services.systemd-run0 = {};                # Custom PAM service, likely for running systemd commands

      # Allow SSH Agent to use PAM for authentication
      sshAgentAuth.enable = true;
    };
  };

  # Setup AppArmor utils
  #environment.systemPackages = with pkgs; [
  #  apparmor-utils
  #  apparmor-pam
  #  apparmor-parser
  #  apparmor-bin-utils
  #];
}
