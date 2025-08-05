{ pkgs, lib, ... }:

{

  home = {
    packages = [
      (pkgs.ollama.override {
        acceleration = "cuda";
      })
    ];
  };
}
