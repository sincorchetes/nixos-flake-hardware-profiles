{ pkgs, ... }:
{
  home.packages = with pkgs; [
    devenv
    kubectl
    kubernetes-helm
    minikube
    direnv
    vscode
    github-copilot-cli
    pre-commit
    jetbrains.datagrip
    dbeaver-bin
    google-cloud-sdk
  ];
}
