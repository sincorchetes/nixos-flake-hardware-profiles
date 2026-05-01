{ nixpkgs-unstable }:
let
  unstablePkgs = import ./nixpkgs-unstable.nix { inherit nixpkgs-unstable; };
  llmPkgs = import ./llm.nix { inherit nixpkgs-unstable; };
in
{
  unstable-overlay = final: prev:
    (unstablePkgs final prev) // (llmPkgs final prev);
}
