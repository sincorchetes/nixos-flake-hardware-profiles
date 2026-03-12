{
  description = "Astro-Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-gcloud-fix.url = "github:NixOS/nixpkgs/pull/496533/head";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cosmic-comp-src = {
      url = "git+file:///home/sincorchetes/Documents/system/cosmic-comp?ref=fix/fullscreen-positioning-and-perf";
      flake = false;
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-gcloud-fix,
      nixpkgs-unstable,
      home-manager,
      disko,
      ...
    }:
    let
      cosmic-comp-src = inputs.cosmic-comp-src;
      overlays = import ./overlays {
        inherit nixpkgs-unstable nixpkgs-gcloud-fix cosmic-comp-src;
      };

      specialArgs = { inherit inputs; };

      commonModules = [
        {
          nixpkgs.overlays = [
            overlays.gcloud-overlay
            overlays.unstable-overlay
            overlays.cosmic-comp-overlay
          ];
        }
        disko.nixosModules.disko
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
      };
    };
}
