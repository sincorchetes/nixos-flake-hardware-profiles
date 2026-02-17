{ config, pkgs, inputs, ... }: 

{
  system.stateVersion = "25.11";

  nix = {
    settings = {
      trusted-users = [ "root" "sincorchetes" ];
      download-buffer-size = 10737418240;
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true; 
    };
  };

  #sops = {
  #  age.keyFile = "/home/sincorchetes/.config/sops/age/keys.txt"; 
  #  defaultSopsFile = ./secrets.yaml;
  #  secrets = {
  #    root_password.neededForUsers = true;
  #    sincorchetes_password.neededForUsers = true;
  #  };
  #};

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.sincorchetes = import ../../home/sincorchetes;
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
    hyprland.enable = true; 
    dconf.enable = true;
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

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.mutter]
    experimental-features=['scale-monitor-framebuffer']
  '';

}
