{pkgs, ...}: {
  home.packages = with pkgs; [
    gnomeExtensions.pop-shell
    gnomeExtensions.easyeffects-preset-selector
    gnomeExtensions.appindicator
  ];
}
