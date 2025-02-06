{ pkgs, lib, ... }:

{

  home = {
    
    packages = with pkgs ; [
      google-chrome
      firefox
      transmission_4-gtk
    ];
  };
}
