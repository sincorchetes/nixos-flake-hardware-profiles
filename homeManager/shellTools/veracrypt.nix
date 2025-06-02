{ pkgs, lib, ... }:

{

  home = {
    packages = with pkgs ; [
      veracrypt

    ];
  };
}
