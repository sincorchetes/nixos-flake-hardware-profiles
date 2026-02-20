{
  inputs,
  config,
  pkgs,
  ...
}:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.sincorchetes = import ../../home/sincorchetes;
  };

  # Define user at system level to resolve homeDirectory conflict
  users.users.sincorchetes = {
    isNormalUser = true;
    home = "/home/sincorchetes";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" ];
  };
}