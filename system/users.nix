{ config, pkgs, ... }:

{
  
  users.users = {
    root.hashedPasswordFile = config.sops.secrets.root_password.path;

    sincorchetes = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Álvaro Castillo";
      hashedPasswordFile = config.sops.secrets.sincorchetes_password.path;
      extraGroups = [ "input" "audio" "video" "users" "networkmanager" "wheel" "render" "docker" "libvirtd" "kvm" ];
    };
  };
}
