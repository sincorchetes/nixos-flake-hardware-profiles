{ config, pkgs, ... }:


{
    services.ollama = {
        enable = true;
        acceleration = "cuda";
        host = "127.0.0.1";
        port = 11434;
        openFirewall = false;
        package = pkgs.ollama-cuda;
    };
}