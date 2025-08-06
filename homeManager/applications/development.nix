{ pkgs, lib, ... }:

let
  gcloud = pkgs.google-cloud-sdk.withExtraComponents [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ];
in

{

  home = {
    packages = with pkgs ; [
        pre-commit
        devenv
        argo
        jq
        stripe-cli
        openssl
        lmstudio
        postman
        helix
        vim
        jetbrains.pycharm-professional
        jetbrains.webstorm
        nix-search-cli
        gpt4all-cuda
        jetbrains.datagrip
        dbeaver-bin
        gh
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
        figma-linux
        gnome-notes
        endeavour
        _1password-gui
        pinentry-curses
        code-cursor
        vscode-fhs
    ];
  };
}
