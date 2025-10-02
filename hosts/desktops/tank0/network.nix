{
  networking = {
    hostName = "tank0";
    networkmanager = {
      enable = true;
      ensureProfiles = {
        profiles = {
          "kvm-bridge" = {
            connection = {
              id = "kvm-bridge-br0";
              type = "bridge";
              interface-name = "br0";
            };
            bridge = {
              stp = false;
            };
            ipv4 = {
              method = "auto";
            };
            ipv6 = {
              method = "disabled";
            };
          };

          "eno1-slave" = {
            connection = {
              id = "eno1-slave-to-br0";
              type = "ethernet";
              interface-name = "eno1";
              master = "kvm-bridge-br0";
              slave-type = "bridge";
            };
          };
        };
      };
    };
  };
}
