{ pkgs, lib, ... }:

let
  gcloud = pkgs.google-cloud-sdk.withExtraComponents [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ];
in

{

  home = {
    packages = with pkgs ; [
        pre-commit
        helix
        vim
        jetbrains.pycharm-professional
        gpt4all
        jetbrains.datagrip
        dbeaver-bin
        gh
        git
        typora
        asciinema
        kubectl
        lens
        gcloud
        istioctl
        kubernetes-helm
        minikube
        terraform
        terragrunt
        awscli2
        gh
        remmina
        azure-cli
        azure-cli-extensions.azure-devops
        alacritty
        figma
    ];
  };
}
