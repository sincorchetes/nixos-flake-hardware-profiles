{
  xdg.desktopEntries = {
    pritunl-client = {
      name = "Pritunl Client";
      genericName = "VPN Client";
      comment = "Launch Pritunl Client";
      exec = "pritunl-client-electron";
      icon = "pritunl_client_electron";
      type = "Application";
      categories = [ "Network" "Utility" ];
      terminal = false;
    };
    steam-nvidia = {
      name = "Steam (NVIDIA)";
      comment = "Steam launcher using NVIDIA GPU (prime-run)";
      exec = "prime-run steam %U";
      icon = "steam";
      terminal = false;
      type= "Application";
      categories = [ "Game" "Entertainment" ];
      startupNotify = true;
    };
  };
}
