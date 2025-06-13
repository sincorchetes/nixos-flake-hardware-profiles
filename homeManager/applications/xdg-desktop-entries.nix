{
  xdg.desktopEntries = {
    firefox-custom = {
      name = "Pritunl Client";
      genericName = "VPN Client";
      comment = "Launch Pritunl Client";
      exec = "pritunl-client-electron";
      icon = "pritunl_client_electron";
      type = "Application";
      categories = [ "Network" "TrayIcon" ];
      terminal = false;
    };
  };
}
