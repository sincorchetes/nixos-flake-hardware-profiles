{
  networking = {
    hostName = "tank0";
    bridges.br0.interfaces = [ "eno1" ];
    networkmanager = {
      enable = true;
      unmanaged = [
        "interface-name:br0"
        "interface-name:eno1"
      ];
    };
  };
}
