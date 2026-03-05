{ pkgs, ... }:
{
  home.packages = with pkgs; [
    devenv
    kubectl
    kubernetes-helm
    minikube
    direnv
    vscode
    jetbrains.pycharm
    jetbrains.webstorm
    antigravity
    pre-commit
    jetbrains.datagrip
    dbeaver-bin
    google-cloud-sdk
  ];
}
