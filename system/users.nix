{ config, pkgs, ... }:

{
  sops.defaultSopsFile = ./secrets.yaml
  sops.secrets = {
    root_password = {};

  };
  users.users = {
    root.hashedPasswordFile = config.sops.secrets.root_password.path;
    
    sincorchetes = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Álvaro Castillo";
      extraGroups = [ "input" "audio" "video" "users" "networkmanager" "wheel" "render" "docker" "libvirtd" "kvm" ];
    };
  };
}