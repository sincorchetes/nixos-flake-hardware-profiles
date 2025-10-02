{
  networking.useNetworkd = true;

  systemd.network.netdevs."10-br0" = {
    netdevConfig = {
      Name = "br0";
      Kind = "bridge";
    };
  };

  systemd.network.networks."20-br0-dhcp" = {
    matchConfig = { Name = "br0"; };
    networkConfig = {
      DHCP = "ipv4";
    };
  };

  systemd.network.networks."30-eno1-slave" = {
    matchConfig = { Name = "eno1"; };
    networkConfig = {
      Bridge = "br0";
    };
  };

}
