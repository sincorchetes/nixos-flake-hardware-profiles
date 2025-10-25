{
    home.file.".config/hypr/wallpaper.png" = {
        source = ./wallpaper.png;
    };
    services.mako = {
        enable = true;
        settings = {
            input-field = {
                monitor = "";
                fade_on_empty = false;
            };

            background = {
                monitor = "";
                path = "~/.config/hypr/wallpaper.png";
            };
        };
    };
}