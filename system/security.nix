{ pkgs, ... }:

{
  security = {
    lsm = [ "apparmor" ];
    sudo = {
      enable = true;
      extraConfig = ''
        Defaults env_keep += "SOPS_AGE_KEY_FILE"
      '';
    };

    apparmor.enable = true;
    rtkit.enable = true;
  };

  boot = {
      kernelModules = [ "apparmor" ];
      kernelParams = [ "apparmor=1" ];
    };

  environment.systemPackages = with pkgs; [
    apparmor-utils
    apparmor-pam
    apparmor-parser
    apparmor-bin-utils
  ];
}
