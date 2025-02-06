{
  # Description
  description = "nixOS configuration file";
  
  # Inputs section
  inputs = {
    
    # Nixpkgs repository
    # Update this to your desired nixpkgs version.
    # For example, to use the latest stable nixpkgs, use:
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };

    # Home Manager configuration manager
    # Update this to your desired home-manager version.
    # For example, to use the latest stable home-manager, use:
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
    };

    # Disabled at the moment. It got a lot of updates and generates to much IOs
    #cosmic = {
    #  url = "github:lilyinstarlight/nixos-cosmic";
    #};
  };

  # Outputs section
  # For enable cosmic you must set up cosmic it.
  outputs = inputs@{ nixpkgs, home-manager, ... }: {

    # Some hardware configurations profiles
    nixosConfigurations = {

      # Main system
      tank0 = import ./hosts/desktops/tank0.nix { inherit nixpkgs home-manager inputs; };

      # Lenovo Thinkpad x270 laptop
      thinkpad0 = import ./hosts/laptops/thinkpad0.nix { inherit nixpkgs home-manager inputs; };

      # HP Probook 440 G8 PC/8A74
      probook0 = import ./hosts/laptops/probook0.nix { inherit nixpkgs home-manager inputs; };
    };
  };
}
