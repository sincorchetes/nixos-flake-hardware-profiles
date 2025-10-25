{
    programs.waybar = {
        enable = true;
        settings = {
            mainBar = {
                height = 40;
                spacing = 0;
                modules-left = ["mpris"];
                modules-center = ["clock"];
                modules-right = [
                                    "wireplumber"
                                    "cpu"
                                    "memory"
                                    "temperature"
                                    "bluetooth"
                                    "power-profiles-daemon"
                                    "tray"
                                    "custom/power"
                                ];
                "wireplumber" = {
                    "format" = "{volume}%  {icon}   {format_source}";
                    "format-bluetooth" = "{volume}% {icon} {format_source}";
                    "format-bluetooth-muted" = " {icon} {format_source}";
                    "format-muted" = " {format_source}";
                    "format-source" = "  {volume}% ";
                    "format-source-muted" = "";
                    "on-click" = "pavucontrol";
                    "format-icons" = {
                        "headphone" = "";
                        "hands-free" = "";
                        "headset" = "";
                        "phone" = "";
                        "portable" = "";
                        "car" = "";
                        "default" = ["" "" ""];
                    };
                "bluetooth" = {
                    "format" = "";
                    "on-click" = "blueman-manager";
                    "format-icons" = {
                    "on" = "";
                    "off" = "";
                    "connected" = "";
                };
                "tray"= {
                    "spacing"= 10
                };
                "clock" = {
                    "format" = "{:%H:%M}  ";
                    "format-alt" = "{:%A, %B %d, %Y (%R)}  ";
                    "tooltip-format" = "<tt><big>{calendar}</big></tt>";
                    "calendar" = {
                        "mode" = "year";
                        "mode-mon-col" = 3;
                        "on-scroll" = 1;
                        "on-click-right" ="mode";
                        "format" = {
                            "months" = "<span color='#ffead3'><b>{}</b></span>";
                            "days" = "<span color='#ecc6d9'><b>{}</b></span>";
                            "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
                            "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
                            "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
                        };
                        "actions" = {
                            "on-click-right" = "mode";
                            "on-click-forward" = "tz_up";
                            "on-click-backward" = "tz_down";
                            "on-scroll-up" = "shift_up";
                            "on-scroll-down" = "shift_down";
                        };
                    };
                "cpu" = {
                    "format" = "{usage}% ";
                    "tooltip" = false;
                };
                "memory" = {
                    "format" = "{}% ";
                };
                "temperature" = {
                    "hwmon-path" = "/sys/class/hwmon/hwmon4/temp1_input";
                    "critical-threshold" = 80;
                    "format" = "{temperatureC}°C {icon}";
                    "format-icons" = ["" "" ""];
                };
                "power-profiles-daemon" = {
                    "format" = "{icon}";
                    "tooltip-format" = "Power profile: {profile}\nDriver: {driver}";
                    "tooltip" = true;
                    "format-icons" = {
                        "default" = "";
                        "performance" = "";
                        "balanced" = "";
                        "power-saver" = "";
                        };
                };
                "mpris" = {
                    "format" = "{artist} - {title}  ";
                    "exec" = "playerctl metadata artist title";
                    "on-click" = "playerctl play-pause";
                };
                "custom/power" = {
                    "format" = "⏻ ";
                    "tooltip" = false;
                    "menu" = "on-click";
                    "menu-file" = "~/.config/waybar/power_menu.xml";
                    "menu-actions" = {
                        "shutdown" = "systemctl poweroff";
                        "reboot" = "systemctl reboot";
                        "suspend" = "systemctl suspend";
                        "hibernate" = "systemctl hibernate";
                    };
                };
            };
        };
    };
}