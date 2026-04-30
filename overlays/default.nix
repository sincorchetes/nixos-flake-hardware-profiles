{
  nixpkgs-unstable,
}:
let
  importPkgs = src: prev:
    import src {
      inherit (prev.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
in
{
  unstable-overlay = final: prev:
    let
      unstable = importPkgs nixpkgs-unstable prev;
      pickPkgs =
        names:
        builtins.listToAttrs (
          map (name: {
            inherit name;
            value = unstable.${name};
          }) names
        );
    in
    pickPkgs [
      "vscode"
      "google-cloud-sdk"
      "claude-code"
      "claude-agent-acp"
      "claude-monitor"
      "antigravity"
      "ollama-cuda"
      "litellm"
    ];

}
