{ config, inputs, ... }:

{
  system.stateVersion = "25.11";

  nix = {
    settings = {
      trusted-users = [ "root" "sincorchetes" ];
      download-buffer-size = 10737418240;
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };

  sops = {
    age.keyFile = "/home/sincorchetes/.config/sops/age/keys.txt"; # 
    defaultSopsFile = ../../secrets.yaml;
    secrets = {
      root_password.neededForUsers = true;
      sincorchetes_password.neededForUsers = true;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.sincorchetes = import ../../home/sincorchetes;
  };
}
