{
  description = "Astro-Modular NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = inputs@{ nixpkgs, home-manager, disko, sops-nix, ... }:
    let
      specialArgs = { inherit inputs; };
    in {
      nixosConfigurations = {
        tank0 = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [ 
            ./profiles/tank/default.nix 
            disko.nixosModules.disko 
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            ];
        };
        #probook0 = nixpkgs.lib.nixosSystem {
        #  inherit specialArgs;
        #  modules = [ ./profiles/probook/default.nix disko.nixosModules.disko ];
        #};
      };
    };
}