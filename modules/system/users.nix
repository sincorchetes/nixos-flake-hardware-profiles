{ config, pkgs, ... }:

{
  sops = {
    age.keyFile = "/home/sincorchetes/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets.yaml;
    secrets = {
      root_password.neededForUsers = true;
      sincorchetes_password.neededForUsers = true;
    };
  };

  users.users = {
    root.hashedPasswordFile = config.sops.secrets.root_password.path;
    sincorchetes = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Álvaro Castillo";
      hashedPasswordFile = config.sops.secrets.sincorchetes_password.path;
      extraGroups = [ 
        "wheel" "networkmanager" "docker" "libvirtd" "video" "audio" "input" 
      ];
    };
  };
}