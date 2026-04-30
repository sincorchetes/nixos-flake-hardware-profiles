{ pkgs, ... }:
{
  home.packages = with pkgs; [
    devenv
    aider-chat-with-playwright
    kubectl
    kubernetes-helm
    minikube
    vscode
    pre-commit
    jetbrains.datagrip
    dbeaver-bin
    ghostty
    antigravity
    claude-code
    claude-agent-acp
    claude-monitor
    (google-cloud-sdk.withExtraComponents [
      google-cloud-sdk.components.gke-gcloud-auth-plugin
    ])
  ];
}
