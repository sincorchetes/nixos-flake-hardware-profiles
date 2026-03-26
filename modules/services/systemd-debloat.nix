{ lib, ... }:

{
  services.acpid.enable = false;
  services.hardware.bolt.enable = false;

  systemd.services = {
    ModemManager.enable = lib.mkForce false;
    cups-browsed.enable = lib.mkForce false;
  };
}
