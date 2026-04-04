{pkgs, ...}: let
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

  home.file = builtins.listToAttrs (map (name: {
    name = ".config/easyeffects/output/${name}.json";
    value = {source = "${presetsDir}/${name}.json";};
  }) presets);

  home.packages = with pkgs; [
    easyeffects
  ];
}
