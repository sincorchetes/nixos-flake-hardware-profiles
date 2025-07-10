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
}
