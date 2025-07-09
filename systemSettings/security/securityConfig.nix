{ pkgs, ... };

{
  security = {
    sudo.enable = false;
    apparmor = {
      enable = true;
      profiles = [];
    };
    rtkit = {
      enable = true;
    };
    pam = {
      services.systemd-run0 = {};
      sshAgentAuth = {
        enable = true;
      };
    };
  };
  
  environment.systemPackages = with pkgs; [
    apparmor-utils
    apparmor-profiles
    apparmor-pam
    apparmor-parser
    apparmor-bin-utils
  ];
}
