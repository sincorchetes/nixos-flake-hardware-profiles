# tank0/default.nix

{ nixpkgs, home-manager, ... }:

nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    {
      nixpkgs.config = {
        allowUnfree = true;
        allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          #"google-chrome"
        ];
      };
    }
    ./configuration.nix
    home-manager.nixosModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.sincorchetes = import ./../common/home-manager/home.nix;
      };
      nixpkgs = {
        config = {
          allowUnfree = true;
          allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
            #"google-chrome"
          ];
        };
      };
    }
  ];
}
