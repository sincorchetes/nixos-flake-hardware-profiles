{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       #virtualbox
    ];
  };

  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };

  };

  users = {
    users = {
      sincorchetes = {
        extraGroups = ["vboxusers"];
      };
    };
  };
}
