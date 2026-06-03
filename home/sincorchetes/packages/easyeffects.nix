{pkgs, lib, ...}: let
  presetsDir = ./easyeffects-presets;
  presets = [
    "Input - StreamCam"
    "Cinema - Movies"
    "Gaming - Generic"
    "Music - Commercial"
    "Music - Drum and Bass"
    "Music - Electro"
    "Music - Hip Hop RNB"
    "Music - House"
  ];
in {

  home.file = builtins.listToAttrs (map (name:
    let
      type = if lib.hasPrefix "Input - " name then "input" else "output";
    in {
      name = ".local/share/easyeffects/${type}/${name}.json";
      value = {source = "${presetsDir}/${name}.json";};
    }
  ) presets);

  home.packages = with pkgs; [
    easyeffects
  ];
}
