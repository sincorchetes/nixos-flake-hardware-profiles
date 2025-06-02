{ pkgs, lib, ... }:

{

  home = {
    
    packages = with pkgs ; [
      google-chrome
      brave
      firefox
    ];
  };
}
