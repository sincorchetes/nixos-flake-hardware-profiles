{ config, pkgs, ... }:

{
  users.mutableUsers = true;
  users.users = {
    #root.hashedPasswordFile = config.sops.secrets.root_password.path;
    sincorchetes = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Álvaro Castillo";
      #hashedPasswordFile = config.sops.secrets.sincorchetes_password.path;
      extraGroups = [ 
        "wheel" "networkmanager" "docker" "libvirtd" "video" "audio" "input" 
      ];
    };
  };
}
