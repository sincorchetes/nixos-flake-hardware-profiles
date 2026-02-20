{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
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
