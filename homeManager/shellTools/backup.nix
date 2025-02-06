{ pkgs, lib, ... }:

{

  home = {
    packages = with pkgs ; [
      borgbackup

    ];
  };
}
