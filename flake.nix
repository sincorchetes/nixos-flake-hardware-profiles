{
  description = "nixOS configuration file";
  
  inputs = {
    
    nixpkgs = {
      url = "github:NixOS/nixpkgs/24.11";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      tank0 = import ./tank0/default.nix { inherit nixpkgs home-manager; };
      thinkpad0 = import ./thinkpad0/default.nix { inherit nixpkgs home-manager; };
      probook0 = import ./probook0/default.nix { inherit nixpkgs home-manager; };
  };
};
}
