{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       pritunl-client
       openfortivpn
    ];
  };
}
