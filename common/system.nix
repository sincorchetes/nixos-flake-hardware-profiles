{ config, pkgs, ... }:

{

  # Enable @wheel

  nix = {
          settings = {
            allowed-users = [ "@wheel" ];
            extra-experimental-features = [ "nix-command" "flakes" ];
          }; 
          # devenv 
          extraOptions = ''
            trusted-users = root sincorchetes
          '';
      };
  # Set your time zone

  time.timeZone = "Atlantic/Canary";

  # Configure console keymap
  console.keyMap = "es";

  # RTKit 
  security.rtkit.enable = true;
  security.pam.sshAgentAuth.enable = true;

  # Power Management
  powerManagement.enable = true;  

  # Nvidia environment variables
  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
  };

  virtualisation = {
    vmware.host.enable = true;
    docker.enable = true;
    libvirtd.enable = true;
    #containers.enable = true;
  };
}
