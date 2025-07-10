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

  boot.kernelParams = [
    "security=selinux"
    "selinux=1"
    "enforcing=0"
    "lsm=selinux,apparmor,yama,landlock,bpf"
  ];
}
