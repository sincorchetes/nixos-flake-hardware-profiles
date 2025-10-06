{ config, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      root_password = {};
    };
  };
  users.users = {
    root.hashedPasswordFile = config.sops.secrets.root_password.root_password_hash;

    sincorchetes = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Álvaro Castillo";
      extraGroups = [ "input" "audio" "video" "users" "networkmanager" "wheel" "render" "docker" "libvirtd" "kvm" ];
    };
  };
}
