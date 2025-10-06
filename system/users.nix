{ config, pkgs, ... }:

{
  users.users = {
    root = {
      password = "$6$Re/KYgDT9dBMFt6J$2F9eykAcEONLmTs1cI8YhnuXPU0uDCVzKUntT/EmOKb3dR3xW9QyNbdj7sajAZmPQIAtJ2PmigCy7GaBYwc/21";
    };
    sincorchetes = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Álvaro Castillo";
      extraGroups = [ "input" "audio" "video" "users" "networkmanager" "wheel" "render" "docker" "libvirtd" "kvm" ];
    };
  };
}