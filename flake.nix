{
  description = "Astro-Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-gcloud-fix.url = "github:NixOS/nixpkgs/pull/496533/head";
    nixpkgs-gemini-cli-fix.url = "github:NixOS/nixpkgs/pull/493629/head";
    cosmic-comp = {
      url = "github:sincorchetes/cosmic-comp";
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
      nixpkgs-gemini-cli-fix,
      nixpkgs-unstable,
      cosmic-comp,
      xdg-desktop-portal-cosmic-src,
      home-manager,
      disko,
      ...
    }:
    let
      overlays = import ./overlays {
        inherit nixpkgs-unstable nixpkgs-gcloud-fix nixpkgs-gemini-cli-fix;
      };

      specialArgs = { inherit inputs; };

      commonModules = [
        {
          nixpkgs.overlays = [
            overlays.gcloud-overlay
            overlays.gemini-cli-overlay
            overlays.unstable-overlay 
            # Patched cosmic-comp binary (NVIDIA hotplug) + data files from nixpkgs
            # NOTE: To use patched libcosmic in cosmic-comp, update its Cargo.toml/Cargo.lock
            #   in the cosmic-comp repo to point to sincorchetes/libcosmic (refactor/code-quality-alignment)
            (final: prev: {
              cosmic-comp = final.symlinkJoin {
                name = "cosmic-comp-patched";
                paths = [
                  # Patched binary goes first → wins over prev.cosmic-comp binary
                  cosmic-comp.packages.${final.system}.default
                  # Data files (keybindings.ron, tiling-exceptions.ron) come from nixpkgs
                  prev.cosmic-comp
                ];
              };
            })
            # Patched xdg-desktop-portal-cosmic (fix interactive screenshot race condition)
            (final: prev: {
              xdg-desktop-portal-cosmic = prev.xdg-desktop-portal-cosmic.overrideAttrs (old: {
                src = xdg-desktop-portal-cosmic-src;
                cargoDeps = final.rustPlatform.fetchCargoVendor {
                  src = xdg-desktop-portal-cosmic-src;
                  name = "xdg-desktop-portal-cosmic-vendor";
                  hash = "sha256-99MGWfZrDOav77SRI7c5V21JTfkq7ejC7x+ZiQ5J0Yw=";
                };
              });
            })
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
