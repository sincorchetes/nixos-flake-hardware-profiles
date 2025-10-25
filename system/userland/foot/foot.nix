{
  programs.foot = {
    enable = true;
    settings = {
      "main" = {
        "font" = "FiraCode Nerd Font Mono:size=12";
        "term" = "foot";
      };
      "scrollback" = {
        "lines" = 30000;
      };
    };
  };

  services.foot = {
    enable = true;
  };
}