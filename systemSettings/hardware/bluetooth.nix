{ config, lib, pkgs, ... }:

{

  # Custom hardware settings
  hardware = {

    # Enable Bluetooth and turn it on at boot time
    # This allows the device to connect to other devices over Bluetooth
    # (e.g., for remote control)
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

}