{ config, pkgs, ... }:

{
  users.mutableUsers = true;
  users.users = {
    sincorchetes = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Álvaro Castillo";
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "libvirtd"
        "video"
        "audio"
        "input"
      ];
    };
  };
}
