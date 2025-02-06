{ nixpkgs, home-manager, inputs, ... }:


nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./probook0/configuration.nix
    ../../systemSettings/packageManagers/nix.nix
    home-manager.nixosModules.home-manager
  ];
  
}
