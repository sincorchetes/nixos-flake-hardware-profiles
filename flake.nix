{
  description = "Astro-Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-gcloud-fix.url = "github:NixOS/nixpkgs/pull/496533/head";
    nixpkgs-gemini-cli-fix.url = "github:NixOS/nixpkgs/pull/493629/head";
    cosmic-comp = {
      url = "github:sincorchetes/cosmic-comp/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    xdg-desktop-portal-cosmic-src = {
      url = "github:sincorchetes/xdg-desktop-portal-cosmic/fix/screenshot-output-race";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
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
      overlays = import ./overlays {
        inherit nixpkgs-unstable nixpkgs-gcloud-fix;
      };

      specialArgs = { inherit inputs; };

      commonModules = [
        {
          nixpkgs.overlays = [
            overlays.gcloud-overlay
            overlays.unstable-overlay
            
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
