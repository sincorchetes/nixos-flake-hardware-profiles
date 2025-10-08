{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    ../../system/importer.nix
  ];

  hardware = {
    cpu.amd.updateMicrocode = true;
  };

  services = {
    spice-vdagentd.enable = true;
    qemuGuest.enable = true;
    xserver.videoDrivers = [ "modesetting" "fbdev" ];
    zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };
  };

  networking = {
    hostName = "atlas0";
    hostId = "F1A234E0";
  };

  environment = {

    systemPackages = with pkgs; [
      microcodeAmd
      glxinfo
      spice-vdagent
      spice-autorandr
      vulkan-tools
    ];
  };

  boot = {
    kernelParams = [
      "preempt=full"
    ];
    supportedFilesystems = [ "zfs" ];
    initrd = {
      supportedFilesystems = [ "zfs" ];
      kernelModules = [ "zfs" ];
    };
  };
}
