{
    wayland.windowManager.hyprland = {
        enable = true;
        settings = {

            "$terminal" = "rio";
            "$fileManager" = "nautilus";
            "$menu" = "wofi --show drun --insensitive";
            "$mainMod" = "SUPER";

            monitor = [
                "DP-2, preferred, auto, 1.25"
                "HDMI-A-1, disable"
            ];

            exec-once = [
                "easyeffects -w"
                "hyprctl setcursor Adwaita 24"
                "1password --silent &"
                "waybar"
            ];

            env = [
                "XCURSOR_SIZE,24"
                "HYPRCURSOR_SIZE,24"
                "LIBVA_DRIVER_NAME,radeonsi"
                "VDPAU_DRIVER,radeonsi"
                "ELECTRON_OZONE_PLATFORM_HINT,auto"
                "HYPRCURSOR_THEME,Adwaita"
                "QT_QPA_PLATFORM,wayland"
                "NIXOS_OZONE_WL,1 "
                "GTK_THEME, Adwaita-dark"
                "GDK_SCALE,2"
            ];

            general = {
                gaps_in = 5;
                gaps_out = 20;
                border_size = 3;
                "col.active_border" = "rgba(FFFFFFFF)";
                "col.inactive_border" = "rgba(595959aa)";
                resize_on_border = false;
                allow_tearing = false;
                layout = "dwindle";
            };

            decoration = {
                rounding = 10;
                active_opacity = 1.0;
                inactive_opacity = 1.0;

                shadow = {
                    enabled = true;
                    range = 4;
                    render_power = 3;
                    color = "rgba(1a1a1aee)";
                };

                blur = {
                    enabled = true;
                    size = 3;
                    passes = 1;
                    vibrancy = 0.1696;
                };
            };

            animations = {
                enabled = true;

                bezier = [
                    "easeOutQuint,0.23,1,0.32,1"
                    "easeInOutCubic,0.65,0.05,0.36,1"
                    "linear,0,0,1,1"
                    "almostLinear,0.5,0.5,0.75,1.0"
                    "quick,0.15,0,0.1,1"
                ];

                animation = [
                    "global, 1, 10, default"
                    "border, 1, 5.39, easeOutQuint"
                    "windows, 1, 4.79, easeOutQuint"
                    "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
                    "windowsOut, 1, 1.49, linear, popin 87%"
                    "fadeIn, 1, 1.73, almostLinear"
                    "fadeOut, 1, 1.46, almostLinear"
                    "fade, 1, 3.03, quick"
                    "layers, 1, 3.81, easeOutQuint"
                    "layersIn, 1, 4, easeOutQuint, fade"
                    "layersOut, 1, 1.5, linear, fade"
                    "fadeLayersIn, 1, 1.79, almostLinear"
                    "fadeLayersOut, 1, 1.39, almostLinear"
                    "workspaces, 1, 1.94, almostLinear, fade"
                    "workspacesIn, 1, 1.21, almostLinear, fade"
                    "workspacesOut, 1, 1.94, almostLinear, fade"
                ];
            };

            dwindle = {
                pseudotile = true;
                preserve_split = true;
            };

            master = {
                new_status = "master";
            };

            misc = {
                force_default_wallpaper = 0;
                disable_hyprland_logo = true;
                vfr = 0;
            };

            render = {
                explicit_sync = 2;
                explicit_sync_kms = 0;
            };

            debug = {
                damage_tracking = 0;
            };

            input = {
                kb_layout = "es";
                follow_mouse = 1;
                sensitivity = 1.0; 

                touchpad = {
                    natural_scroll = false;
                };
            };
            
            gestures = {
                workspace_swipe = false;
            };

            device = {
                name = "logitech-wireless-mouse-1";
                sensitivity = 1;
            };

            windowrule = [
              "float, class:copyq"
            ];
            windowrulev2 = [
                "suppressevent maximize, class:.*"
                "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
            ];
            
            xwayland = {
                force_zero_scaling = true;
                use_nearest_neighbor = true;
            };

            bind = [
                "$mainMod, RETURN, exec, $terminal"
                "$mainMod, Q, killactive,"
                "$mainMod, E, exit,"
                "$mainMod, F, exec, $fileManager"
                "$mainMod, V, togglefloating,"
                "$mainMod, F1, exec, telegram-desktop"
                "$mainMod, F2, exec, brave"
                "$mainMod, F3, exec, virt-manager"
                "$mainMod, F4, exec, obs --startrecording --minimize-to-tray"
                "$mainMod, P, pseudo,"
                "$mainMod, D, exec, $menu"
                "$mainMod, J, togglesplit,"
                "$mainMod, L, exec, hyprlock"
                "$mainMod, Z, exec, copyq"
                "$mainMod, left, movefocus, l"
                "$mainMod, right, movefocus, r"
                "$mainMod, up, movefocus, u"
                "$mainMod, down, movefocus, d"
                "$mainMod, 1, workspace, 1"
                "$mainMod, 2, workspace, 2"
                "$mainMod, 3, workspace, 3"
                "$mainMod, 4, workspace, 4"
                "$mainMod, 5, workspace, 5"
                "$mainMod, 6, workspace, 6"
                "$mainMod, 7, workspace, 7"
                "$mainMod, 8, workspace, 8"
                "$mainMod, 9, workspace, 9"
                "$mainMod, 0, workspace, 10"
                "$mainMod SHIFT, 1, movetoworkspace, 1"
                "$mainMod SHIFT, 2, movetoworkspace, 2"
                "$mainMod SHIFT, 3, movetoworkspace, 3"
                "$mainMod SHIFT, 4, movetoworkspace, 4"
                "$mainMod SHIFT, 5, movetoworkspace, 5"
                "$mainMod SHIFT, 6, movetoworkspace, 6"
                "$mainMod SHIFT, 7, movetoworkspace, 7"
                "$mainMod SHIFT, 8, movetoworkspace, 8"
                "$mainMod SHIFT, 9, movetoworkspace, 9"
                "$mainMod SHIFT, 0, movetoworkspace, 10"
                "$mainMod, S, togglespecialworkspace, magic"
                "$mainMod SHIFT, S, movetoworkspace, special:magic"
                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"
                ", PRINT, exec, hyprshot -m region"
            ];

            bindm = [
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
            ];

            bindel = [
                ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
                ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
                ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
            ];

            bindl = [
                ", XF86AudioNext, exec, playerctl next"
                ", XF86AudioPause, exec, playerctl play-pause"
                ", XF86AudioPlay, exec, playerctl play-pause"
                ", XF86AudioPrev, exec, playerctl previous"
            ];
        };
    };
}