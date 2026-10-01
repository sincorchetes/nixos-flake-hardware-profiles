{
  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
    ports = [
      22
      2222
    ];
  };

  # Solo accesible desde la tailnet, ni LAN ni internet
  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [
    22
    2222
  ];
}
