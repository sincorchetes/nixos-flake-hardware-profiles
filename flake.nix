{
  # Description
  description = "nixOS configuration file";
  
  # Inputs section
  inputs = {
    
    # Nixpkgs repository
    # Update this to your desired nixpkgs version.
    # For example, to use the latest stable nixpkgs, use:
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };


    # Home Manager configuration manager
    # Update this to your desired home-manager version.
    # For example, to use the latest stable home-manager, use:
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
    };

    # Uses stable version for home-manager software.
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  # Outputs section
  # For enable cosmic you must set up cosmic it.
  outputs = inputs@{ nixpkgs, home-manager, ... }:

  let
    # Declare some shared variables between hosts profiles:
    system = "x86_64-linux";

    # Declare the pkgs stable section
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    # Declare the pkgs stable section
    pkgsUnstable = import inputs."nixpkgs-unstable" {
      inherit system;
      config.allowUnfree = true;
    };

    # Use the shareable variables declared before into host profiles.
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
  in {
    # Some hardware configurations profiles
    nixosConfigurations = {
      tank0     = mkSystem ./hosts/desktops/tank0/configuration.nix;
      thinkpad0 = mkSystem ./hosts/laptops/thinkpad0/configuration.nix;
      probook0  = mkSystem ./hosts/laptops/probook0/configuration.nix;
    };
  };
}
