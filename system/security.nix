{ pkgs, ... }:

{
  security = {
    sudo.enable = true;
    apparmor.enable = true;
    rtkit.enable = true;
  };

  environment.systemPackages = with pkgs; [
    apparmor-utils
    apparmor-pam
    apparmor-parser
    apparmor-bin-utils
  ];
}