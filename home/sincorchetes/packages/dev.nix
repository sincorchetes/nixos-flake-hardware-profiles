{pkgs, ...}: {
  home.packages = with pkgs; [
    devenv
    kubectl
    kubernetes-helm
    minikube
    direnv
    vscode
    code-cursor
    jetbrains.pycharm
    jetbrains.webstorm
    antigravity
    pre-commit
    jetbrains.datagrip
    dbeaver-bin
    google-cloud-sdk
  ];
}
