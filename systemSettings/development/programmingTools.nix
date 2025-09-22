{ config, lib, pkgs, pkgsUnstable, ... }:

{

  environment = {
    systemPackages = [ 
      pkgs.git 
      pkgs.cachix 
    ];
  };

  #services = {
  #  ollama = {
  #    enable = true;
  #    acceleration = "cuda";
  #    package = pkgsUnstable.ollama-cuda;
  #  };
  #};
}
