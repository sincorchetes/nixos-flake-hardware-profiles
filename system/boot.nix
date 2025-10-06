{ pkgs, ...}:

{
  boot = {

    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };

    kernelPackages = pkgs.linuxPackages_zen;

    supportedFilesystems = [ "ntfs" ];
        environment = {
            systemPackages = with pkgs; [
            ntfs3g
            ];
        };
    };

    environment = {
    systemPackages = with pkgs; [
       linux-firmware
       fwupd
       fwupd-efi
    ];
  };

}