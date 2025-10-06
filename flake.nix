{
  description = "nixOS configuration file";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      pkgsUnstable = import inputs."nixpkgs-unstable" {
        inherit system;
        config.allowUnfree = true;
      };

      mkSystem = path:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgsUnstable; };
          modules = [
            path
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit pkgsUnstable; };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        tank0     = mkSystem ./profiles/desktops/tank.nix;
        thinkpad0 = mkSystem ./profiles/laptops/thinkpad.nix;
        probook0  = mkSystem ./profiles/laptops/probook.nix;
      };
    };
}