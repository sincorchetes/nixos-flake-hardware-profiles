{
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  # SSH solo accesible por tailscale0 (interfaz de confianza): no se abre
  # el puerto en el firewall, así que la LAN no llega.
  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
