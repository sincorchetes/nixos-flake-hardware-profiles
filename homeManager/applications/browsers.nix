{ pkgs, lib, ... }:

{

  home = {
    
    packages = with pkgs ; [
      google-chrome
      brave
      firefox
      transmission_4-gtk
    ];
  };
}
