{ pkgs, ... }:

{
  security = {
    apparmor = {
      enable = true;
      enableCache = true;
      packages = with pkgs; [
        apparmor-utils
        apparmor-profiles
      ];
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
    kernelParams = [ "lsm=landlock,lockdown,yama,apparmor,bpf" ];
  };
}