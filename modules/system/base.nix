{
  config,
  pkgs,
  ...
}:

{
  system.stateVersion = "25.11";

  nix = {
    settings = {
      trusted-users = [
        "root"
        "sincorchetes"
      ];
      download-buffer-size = 10737418240;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
  };

  environment.systemPackages = with pkgs; [
    cachix
    acpi
    lm_sensors
    pciutils
    lshw
    usbutils
    binutils
    uutils-coreutils-noprefix
    fwupd
    fwupd-efi
  ];

  programs = {
    zsh.enable = true;
    dconf.enable = true;
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "sincorchetes" ];
    };
  };

  time.timeZone = "Atlantic/Canary";

  console.keyMap = "es";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "es_ES.UTF-8";
      LC_IDENTIFICATION = "es_ES.UTF-8";
      LC_MEASUREMENT = "es_ES.UTF-8";
      LC_MONETARY = "es_ES.UTF-8";
      LC_NAME = "es_ES.UTF-8";
      LC_NUMERIC = "es_ES.UTF-8";
      LC_PAPER = "es_ES.UTF-8";
      LC_TELEPHONE = "es_ES.UTF-8";
      LC_TIME = "es_ES.UTF-8";
    };
  };

  hardware.enableRedistributableFirmware = true;
  services.fwupd.enable = true;
  nixpkgs.config.allowUnfree = true;
}
