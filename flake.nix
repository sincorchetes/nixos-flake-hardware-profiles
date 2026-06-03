{
  description = "Astro-Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      disko,
      lanzaboote,
      ...
    }:
    let
      overlays = import ./overlays {
        inherit nixpkgs-unstable;
      };

      specialArgs = { inherit inputs; };

      commonModules = [
        {
          nixpkgs.overlays = [
            overlays.unstable-overlay
          ];
        }
        disko.nixosModules.disko
        lanzaboote.nixosModules.lanzaboote
        home-manager.nixosModules.home-manager
      ];
    in
    {
      nixosConfigurations = {
        tank0 = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = commonModules ++ [ ./profiles/tank/default.nix ];
        };
        probook0 = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = commonModules ++ [ ./profiles/probook/default.nix ];
        };
        thinkpad-x270 = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = commonModules ++ [ ./profiles/thinkpad-x270/default.nix ];
        };
        cloud0 = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = commonModules ++ [ ./profiles/cloud/default.nix ];
        };
      };
    };
}
