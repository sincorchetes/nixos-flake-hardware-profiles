{ pkgs, ... }:
{
  home.packages = with pkgs; [
    devenv
    kubectl
    kubernetes-helm
    minikube
    vscode
    github-copilot-cli
    pre-commit
    jetbrains.datagrip
    dbeaver-bin
    ghostty
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    antigravity
  ];
}
