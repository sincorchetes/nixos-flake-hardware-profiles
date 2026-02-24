{
  description = "Astro-Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-gcloud-fix.url = "github:NixOS/nixpkgs/pull/492139/head";
    nixpkgs-gemini-cli-fix.url = "github:NixOS/nixpkgs/pull/493629/head";
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
      home-manager,
      disko,
      ...
    }:
    let
      gcloud-overlay = final: prev: {
        google-cloud-sdk = (
          nixpkgs-gcloud-fix.legacyPackages.${prev.system}.google-cloud-sdk.withExtraComponents [
            nixpkgs-gcloud-fix.legacyPackages.${prev.system}.google-cloud-sdk.components.gke-gcloud-auth-plugin
          ]
        );
      };
      specialArgs = { inherit inputs; };
    in
    {
      nixosConfigurations = {
        tank0 = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            { nixpkgs.overlays = [ gcloud-overlay ]; }
            ./profiles/tank/default.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
          ];
        };
        probook0 = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            { nixpkgs.overlays = [ gcloud-overlay ]; }
            ./profiles/probook/default.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
          ];
        };
      };
    };
}
