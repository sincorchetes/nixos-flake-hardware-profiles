{
  security = {
    rtkit = {
      enable = true;
    };
    pam = {
      services.systemd-run0 = {};
      sshAgentAuth = {
        enable = true;
      };
    };
  };
}
