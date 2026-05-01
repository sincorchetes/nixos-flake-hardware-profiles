{ nixpkgs-unstable }:
let
  mkLib = import ./lib.nix nixpkgs-unstable;
in
  final: prev:
    let inherit (mkLib prev) pickPkgs; in
    pickPkgs [
      "vscode"
      "google-cloud-sdk"
      "claude-code"
      "claude-agent-acp"
      "claude-monitor"
      "antigravity"
      "ollama-cuda"
    ]
