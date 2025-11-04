{
  description = "nixOS configuration file";

  inputs = {
    sops-nix.url = "github:Mic92/sops-nix";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Stable channel
    #home-manager = {
    #  url = "github:nix-community/home-manager/release-25.05";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    # Unstable channel
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    #disko = {
    #  url = "github:nix-community/disko";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

  };

  outputs = inputs@{ nixpkgs-unstable, sops-nix, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs = import inputs."nixpkgs-unstable" {
        inherit system;
        config.allowUnfree = true;
      };

      #pkgsUnstable = import inputs."nixpkgs-unstable" {
      #  inherit system;
      #  config.allowUnfree = true;
      #};

      mkSystem = path:
        nixpkgs-unstable.lib.nixosSystem {
          inherit system;
          #specialArgs = { inherit inputs pkgsUnstable; };
          modules = [
            path
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            #disko.nixosModules.disko
            #{
            #  home-manager = {
            #    useGlobalPkgs = true;
            #    useUserPackages = true;
            #    extraSpecialArgs = { inherit pkgsUnstable; };
            #  };
            #}
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
