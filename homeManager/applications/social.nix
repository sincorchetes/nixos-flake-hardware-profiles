{ pkgs, lib, ... }:

{

  home = {
    
    packages = with pkgs ; [
      telegram-desktop
      slack
      discord
    ];
  };
}
