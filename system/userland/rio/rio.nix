{
    programs.rio = {
        enable = true;
        settings = {
            
            "padding-x" = 10;
            "padding-y" = [30 10];
            "use-fork" = true;
            "confirm-before-quit" = false;

            cursor = {
                "shape" = "beam";
                "blinking" = true;
                "blinking-interval" = 800;
            };
            editor = {
                "program" = "nvim";
            };
            window = {
                "opacity" = 0.9;
                "blur" = true;
                "decorations" = "Buttonless";
            };
            renderer = {
                "performance" = "high";
                "backend" = "Vulkan";
                "disable-unfocused-render" = false;
                "level" = 1;
            };
            fonts = {
                "size" = 16;
            };
            navigation = {
                "mode" = "BottomTab";
                "clickable" = true;
                "hide-if-single" = true;
            };
        };
    };
}