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

    sudo.enable = false;
    polkit.enable = true;
    rtkit.enable = true;
  };

  environment.shellAliases = {
    sudo = "run0";
  };

  boot = {
    kernelParams = [ "lsm=landlock,lockdown,yama,apparmor,bpf" ];
  };
}
