{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    ports = [
      22
      2222
    ];
  };

  networking.firewall.allowedTCPPorts = [
    22
    2222
  ];
}
