{ pkgs, config, ... }:
{
  services = {
    fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = with pkgs; [ 
          libfprint-2-tod1-vfs0090 
          libfprint-2-tod1-goodix 
        ];
      };
    };
  };
}
