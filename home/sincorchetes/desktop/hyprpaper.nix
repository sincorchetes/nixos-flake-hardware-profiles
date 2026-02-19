{
  home.file.".config/hypr/wallpaper.png" = {
    source = ./wallpaper.png;
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [
        "~/.config/hypr/wallpaper.png"
      ];
      wallpaper = [
        ", ~/.config/hypr/wallpaper.png"
      ];
    };
  };
}
