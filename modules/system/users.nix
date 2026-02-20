{
  inputs,
  ...
}:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.sincorchetes = import ../../home/sincorchetes;
  };
}