{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       kernelshark
    ];
  };
}
