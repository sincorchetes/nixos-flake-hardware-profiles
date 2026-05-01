{ nixpkgs-unstable }:
let
  mkLib = import ./lib.nix nixpkgs-unstable;
in
  final: prev:
    let
      inherit (mkLib prev) unstable;

      fixedLitellm = unstable.python312Packages.litellm.overrideAttrs (old: rec {
        version = "1.83.10-custom";

        src = prev.fetchFromGitHub {
          owner = "sincorchetes";
          repo = "litellm";
          rev = "nixos-1.83.10-fixed";
          hash = "sha256-Kb7bJWnDjem4EkJB6t4dufNE7a4OQmmE833S85pNFj0=";
        };

        env.SETUPTOOLS_SCM_PRETEND_VERSION = "1.83.10";

        nativeBuildInputs = (old.nativeBuildInputs or []) ++ [
          unstable.python312Packages.setuptools
          unstable.python312Packages.setuptools-scm
        ];
        dontCheckForBrokenSymlinks = true;
        pythonImportsCheck = [ "litellm" ];
        doCheck = false;
        pythonRelaxDeps = true;
      });

      customPythonPackages = unstable.python312Packages.override {
        overrides = pyFinal: pyPrev: {
          litellm = fixedLitellm;
        };
      };
    in
    {
      aider-chat-with-playwright = (unstable.aider-chat.override {
        python3Packages = customPythonPackages;
      }).passthru.withOptional { withPlaywright = true; };

      litellm = fixedLitellm;
    }
