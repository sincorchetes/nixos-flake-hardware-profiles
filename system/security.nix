{ pkgs, ... }:

{

  # Security Section
  security = {

    # Disable sudo
    sudo.enable = true;

    # Enable AppArmor
    apparmor.enable = true;

    # Enable RealtimeKit for Pipewire
    rtkit.enable = true;

  };

  # Setup AppArmor utils
  environment.systemPackages = with pkgs; [
    apparmor-utils
    apparmor-pam
    apparmor-parser
    apparmor-bin-utils
  ];
}
