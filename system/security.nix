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

    rtkit.enable = true;

    apparmor = {
      enable = true;
      packages = with pkgs; [
        apparmor-utils
        apparmor-pam
        apparmor-parser
        apparmor-bin-utils
        apparmor-profiles
      ];

      system = {
        path = "${pkgs.apparmor-profiles}/etc/apparmor.d";
        state = "enforce";
      };
    };
  };

  boot = {
      kernelModules = [ "apparmor" ];
      kernelParams = [ "apparmor=1" ];
    };

}
