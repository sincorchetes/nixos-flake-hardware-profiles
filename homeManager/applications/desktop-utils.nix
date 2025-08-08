{ pkgs, lib, ... }:

{

  home = {
    
    packages = with pkgs ; [
      copyq
      transmission_4-gtk
      appimage-run
      distrobox
    ];
  };
}
