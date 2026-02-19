{ pkgs, ... }:

{
  virtualisation = {
    docker.enable = true;
    containers.enable = true;
  };

  environment.systemPackages = with pkgs; [
    docker
    docker-buildx
  ];
}
