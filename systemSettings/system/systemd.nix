{ pkgs, ... }:

{
  systemd = {
    packages = [ pkgs.pritunl-client ];
    services = {
      NetworkManager-wait-online.enable = false;
    };
    targets.multi-user.wants = [ "pritunl-client.service" ]; 
  };
}
