nixpkgs-unstable: prev:
let
  unstable = import nixpkgs-unstable {
    inherit (prev.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };
  pickPkgs = names: builtins.listToAttrs (
    map (name: { inherit name; value = unstable.${name}; }) names
  );
in { inherit unstable pickPkgs; }
