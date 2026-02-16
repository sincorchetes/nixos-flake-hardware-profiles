{ pkgs, ... }:

{
  security = {
    apparmor = {
      enable = true;
      packages = with pkgs; [
        apparmor-utils
        apparmor-profiles
      ];
      policies.system.state = "enforce";
    };

    sudo = {
      enable = true;
      extraConfig = ''
        Defaults env_keep += "SOPS_AGE_KEY_FILE"
      '';
    };

    rtkit.enable = true;
  };

  boot = {
    kernelModules = [ "apparmor" ];
    kernelParams = [ "apparmor=1" "lsm=landlock,lockdown,yama,apparmor,bpf" ];
  };
}