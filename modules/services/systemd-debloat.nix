{ lib, ... }:

{
  services.acpid.enable = true;
  services.hardware.bolt.enable = false;

  systemd.services = {
    ModemManager.enable = lib.mkForce false;
    cups-browsed.enable = lib.mkForce false;
  };
}
