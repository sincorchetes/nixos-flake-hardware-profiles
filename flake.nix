{
  description = "Astro-Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-ide-latest.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      nixpkgs-gemini-cli-fix,
      nixpkgs-ide-latest,
      home-manager,
      disko,
      ...
    }:
    let
      gcloud-overlay = final: prev: {
        google-cloud-sdk = (
          (import nixpkgs-gcloud-fix {
            inherit (prev) system;
            config.allowUnfree = true;
          }).google-cloud-sdk.withExtraComponents
            [
              (import nixpkgs-gcloud-fix {
                inherit (prev) system;
                config.allowUnfree = true;
              }).google-cloud-sdk.components.gke-gcloud-auth-plugin
            ]
        );
      };

      gemini-cli-overlay = final: prev: {
        gemini-cli =
          (import nixpkgs-gemini-cli-fix {
            inherit (prev) system;
            config.allowUnfree = true;
          }).gemini-cli;
      };

      ide-overlay = final: prev: {
        antigravity =
          (import nixpkgs-ide-latest {
            inherit (prev) system;
            config.allowUnfree = true;
          }).antigravity;
        vscode =
          (import nixpkgs-ide-latest {
            inherit (prev) system;
            config.allowUnfree = true;
          }).vscode;
      };
      specialArgs = { inherit inputs; };
    in
    {
      nixosConfigurations = {
        tank0 = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            {
              nixpkgs.overlays = [
                gcloud-overlay
                gemini-cli-overlay
                ide-overlay
              ];
            }
            ./profiles/tank/default.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
          ];
        };
        probook0 = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            {
              nixpkgs.overlays = [
                gcloud-overlay
                gemini-cli-overlay
                ide-overlay
              ];
            }
            ./profiles/probook/default.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
          ];
        };
      };
    };
}
