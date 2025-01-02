{ config, pkgs, ... }:

{
  imports =
    [
      ./packages.nix
      ./programs.nix
    ];

  home = {
    username = "sincorchetes";
    homeDirectory = "/home/sincorchetes";
      
    sessionVariables = {
      EDITOR = "vim";
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
      XCURSOR_THEME = "Adwaita";
      XCURSOR_SIZE = "24"; 
    };
  };
}
