{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       #devenv
       cachix
       #vscode.fhs
    ];
  };
}
