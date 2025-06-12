{ pkgs, ... }:

{
  systemd = {
    packages = [ pkgs.pritunl-client ];  # make services part of the systemd environment
    targets.multi-user.wants = [ "pritunl-client.service" ]; 
}
