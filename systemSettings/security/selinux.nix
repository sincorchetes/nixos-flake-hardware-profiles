{ pkgs, ... }:

{
  
  # Setup SElinux packages
  environment.systemPackages = with pkgs; [
    selinux-python
    selinux-sandbox
    selinux-refpolicy
    libselinux
    checkpolicy
    setools
    policycoreutils
    libsemanage
    libsepol
    semodule-utils
  ];

  security.lsm = [ "selinux" "apparmor" ];
  boot.kernelParams = [
    "selinux=1"
    "enforcing=0"
  ];

  systemd.package = pkgs.systemd.override {
    withSelinux = true;
  };
}
