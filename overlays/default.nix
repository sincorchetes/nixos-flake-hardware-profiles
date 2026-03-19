{
  nixpkgs-unstable,
  nixpkgs-gcloud-fix,
}:
let
  importPkgs = src: prev:
    import src {
      inherit (prev.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
in
{
  gcloud-overlay = final: prev:
    let
      gcloud = (importPkgs nixpkgs-gcloud-fix prev).google-cloud-sdk;
    in
    {
      google-cloud-sdk = gcloud.withExtraComponents [
        gcloud.components.gke-gcloud-auth-plugin
      ];
    };

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
      "github-copilot-cli"
    ];

}
