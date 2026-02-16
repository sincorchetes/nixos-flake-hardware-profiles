{
  programs.foot = {
    server.enable = true;
    enable = true;
    settings = {
      "main" = {
        "font" = "FiraCode Nerd Font Mono:size=12";
        "dpi-aware" = "no";
        "term" = "foot";
      };
      "scrollback" = {
        "lines" = 30000;
      };
      "colors" = {
        "alpha" = 0.8;
      };
    };
  };
}