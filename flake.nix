{
  description = "nixOS configuration file";

  inputs = {
    sops-nix.url = "github:Mic92/sops-nix";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Unstable channel
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ nixpkgs, sops-nix, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs = import inputs."nixpkgs" {
        inherit system;
        config.allowUnfree = true;
      };

      mkSystem = path:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            path
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            disko.nixosModules.disko
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
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
        atlas0    = mkSystem ./profiles/kvm/atlas.nix;
      };
    };
}
