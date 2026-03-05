{pkgs, ...}: let
  presetsDir = ./easyeffects-presets;
  presets = [
    "Cinema - Movies"
    "Gaming - Generic"
    "Music - Commercial"
    "Music - Drum and Bass"
    "Music - Electro"
    "Music - Hip Hop RNB"
    "Music - House"
  ];
in {
  services.easyeffects = {
    enable = true;
    preset = "Music - Commercial";
    extraPresets = builtins.listToAttrs (map (name: {
      inherit name;
      value = builtins.fromJSON (builtins.readFile "${presetsDir}/${name}.json");
    }) presets);
  };
}
