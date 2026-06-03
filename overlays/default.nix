{ nixpkgs-unstable }:
let
  unstablePkgs = import ./nixpkgs-unstable.nix { inherit nixpkgs-unstable; };
in
{
  unstable-overlay = final: prev:
    (unstablePkgs final prev);
}
