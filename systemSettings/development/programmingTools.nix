{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       #devenv
       cachix
       git
       #vscode.fhs
    ];
  };
}
