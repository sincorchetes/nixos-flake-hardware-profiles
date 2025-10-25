{
    home.file.".config/waybar/power_menu.xml" = {
        source = ./power_menu.xml;
    };
    programs.waybar = {
        enable = true;
        systemd.enable = true;
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
                };
                "bluetooth" = {
                    "format" = "";
                    "on-click" = "blueman-manager";
                    "format-icons" = {
                        "on" = "";
                        "off" = "";
                        "connected" = "";
                    };
                };
                "tray"= {
                    "spacing"= 10;
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

        style = ''
                * {
                    font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
                    font-size: 16px;
                }

                window#waybar {
                    background-color: #373740;
                    color: white;
                    transition-property: background-color;
                    transition-duration: 0.5s;
                }

                window#waybar.hidden {
                    opacity: 0.2;
                }

                window#waybar.termite {
                    background-color: #3f3f3f;
                }

                window#waybar.chromium {
                    background-color: #000000;
                    border: none;
                }

                button {
                    box-shadow: inset 0 -3px transparent;
                    border: none;
                    border-radius: 0px;
                }

                button:hover {
                    background: inherit;
                    box-shadow: inset 0 -3px #ffffff;
                }

                #workspaces button {
                    padding: 0 5px;
                    background-color: transparent;
                    color: #ffffff;
                }

                #workspaces button:hover {
                    background: rgba(0, 0, 0, 0.2);
                }

                #workspaces button.focused {
                    background-color: #64727d;
                    box-shadow: inset 0 -3px #ffffff;
                }

                #workspaces button.urgent {
                    background-color: #eb4d4b;
                }

                #mode {
                    background-color: #64727d;
                    box-shadow: inset 0 -3px #ffffff;
                }

                #clock,
                #cpu,
                #memory,
                #disk,
                #power,
                #temperature,
                #wireplumber,
                #tray,
                #bluetooth,
                #mode,
                #custom-power,
                #mpris,
                #power-profiles-daemon {
                    background-color: transparent;
                    margin: 5px;
                    padding-left: 10px;
                    padding-right: 10px;
                    border-color: #ecf0f1;
                }

                #clock:hover,
                #cpu:hover,
                #memory:hover,
                #disk:hover,
                #temperature:hover,
                #wireplumber:hover,
                #tray:hover,
                #bluetooth:hover,
                #mode:hover,
                #mpris:hover,
                #power-profiles-daemon:hover {
                    background-color: rgba(43, 48, 59, 0.5);
                    color: #ffffff;
                }

                .modules-left > widget:first-child > #workspaces {
                    margin-left: 0;
                }

                .modules-right > widget:last-child > #workspaces {
                    margin-right: 0;
                }

                label:focus {
                    background-color: #000000;
                }

                #temperature.critical {
                    background-color: #eb4d4b;
                }    

                #tray > .passive {
                    -gtk-icon-effect: dim;
                }

                #tray > .needs-attention {
                    -gtk-icon-effect: highlight;
                    background-color: #eb4d4b;
                }

                #keyboard-state > label {
                    padding: 0 5px;
                }

                #keyboard-state > label.locked {
                    background: rgba(0, 0, 0, 0.2);
                }
        '';
    };
}