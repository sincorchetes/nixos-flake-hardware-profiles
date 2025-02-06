{
  security = {
    rtkit = {
      enable = true;
    };
    pam = {
      sshAgentAuth = {
        enable = true;
      };
    };
  };
}