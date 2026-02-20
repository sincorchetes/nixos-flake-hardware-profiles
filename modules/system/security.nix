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

    sudo.enable = true;
    rtkit.enable = true;
  };

  boot = {
    kernelParams = [ "lsm=landlock,lockdown,yama,apparmor,bpf" ];
  };
}
