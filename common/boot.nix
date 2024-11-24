{ config, pkgs, ... }:

{
  boot = {
    
    kernelPackages = pkgs.linuxPackages_latest;
    # Enable EFI support

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

   
    extraModulePackages = [ pkgs.vmware-workstation ];
    
    
  };
}
