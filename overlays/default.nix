{
  nixpkgs-unstable,
  nixpkgs-gcloud-fix,
  cosmic-comp-src,
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
      # COSMIC Desktop
      "cosmic-applets"
      "cosmic-applibrary"
      "cosmic-bg"
      # cosmic-comp is overridden separately via cosmic-comp-overlay
      "cosmic-edit"
      "cosmic-ext-applet-minimon"
      "cosmic-ext-applet-privacy-indicator"
      "cosmic-ext-applet-sysinfo"
      "cosmic-ext-calculator"
      "cosmic-ext-ctl"
      "cosmic-ext-tweaks"
      "cosmic-ext-weather"
      "cosmic-files"
      "cosmic-greeter"
      "cosmic-icons"
      "cosmic-idle"
      "cosmic-initial-setup"
      "cosmic-launcher"
      "cosmic-notifications"
      "cosmic-osd"
      "cosmic-panel"
      "cosmic-player"
      "cosmic-protocols"
      "cosmic-randr"
      "cosmic-reader"
      "cosmic-screenshot"
      "cosmic-session"
      "cosmic-settings"
      "cosmic-settings-daemon"
      "cosmic-store"
      "cosmic-term"
      "cosmic-wallpapers"
      "cosmic-workspaces-epoch"
      "cutecosmic"
      "oboete"
      "tasks"
      "xdg-desktop-portal-cosmic"
    ];

  # Overlay for cosmic-comp with hotplug fix and NVIDIA improvements
  # from sincorchetes/cosmic-comp fork
  cosmic-comp-overlay = final: prev:
    let
      unstable = importPkgs nixpkgs-unstable prev;
    in
    {
      cosmic-comp = unstable.cosmic-comp.overrideAttrs (old: {
        src = cosmic-comp-src;
        # Override cargoDeps to use our fork's Cargo.lock dependencies.
        # cargoHash (a buildRustPackage argument) can't be changed via overrideAttrs,
        # so we explicitly set cargoDeps with the vendored deps from our source.
        # Use lib.fakeHash first, then replace with the real hash from the error.
        cargoDeps = unstable.rustPlatform.fetchCargoVendor {
          src = cosmic-comp-src;
          hash = "sha256-MI8cJzjZd2UeWBESu8xEDYQv0Oa4PRhc4pOCN0zDNO4=";
        };
      });
    };
}
