{
  nixpkgs-unstable,
  nixpkgs-gcloud-fix,
  nixpkgs-easyeffects-fix,
}:
let
  # Helper: importa un nixpkgs alternativo con allowUnfree
  importPkgs = src: prev:
    import src {
      inherit (prev) system;
      config.allowUnfree = true;
    };
in
{
  easyeffects-overlay = final: prev:
    let
      patched = importPkgs nixpkgs-easyeffects-fix prev;
    in
    {
      gnomeExtensions = prev.gnomeExtensions // {
        easyeffects-preset-selector = patched.gnomeExtensions.easyeffects-preset-selector;
      };
    };

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
      # IDEs y herramientas
      "antigravity"
      "vscode"
      "github-copilot-cli"
    ];

}
