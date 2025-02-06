{ config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
       vmware-workstation
    ];
  };

  virtualisation = {
    vmware = {
      host = {
        enable = true;
      };
    };
  };

  boot = {
    extraModulePackages = [ pkgs.vmware-workstation ];
    
  };

}
