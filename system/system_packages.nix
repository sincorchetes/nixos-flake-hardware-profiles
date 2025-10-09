{ pkgs, ... }:

let
  gcloud = pkgs.google-cloud-sdk.withExtraComponents [
    pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
  ];
in
{
  environment.systemPackages = with pkgs; [
    tree eza tmux unzip gnupg unrar btop binutils htop zoxide ncdu fastfetch
    acpi lm_sensors pciutils inetutils lshw usbutils vdpauinfo
    tcpdump nmap p0f wireshark rustscan mesa
    pritunl-client openfortivpn veracrypt borgbackup kernelshark
    jq openssl sops age cachix git pre-commit devenv
    argo stripe-cli terraform terragrunt kubectl lens istioctl
    kubernetes-helm minikube awscli2 azure-cli azure-cli-extensions.azure-devops gcloud
    flat-remix-gnome flat-remix-icon-theme bat kubecolor
    gnomeExtensions.pop-shell
    gnomeExtensions.easyeffects-preset-selector
    gnomeExtensions.appindicator
  ];

  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    nerd-fonts.ubuntu-sans
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono
    roboto
    font-awesome
    noto-fonts-emoji-blob-bin
    powerline-fonts
  ];
}
