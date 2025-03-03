{ config, pkgs, ... }:
{
  imports =
    [ 
      # Common files
      ./../../../systemSettings/containerRuntimes/docker.nix
      ./../../../systemSettings/desktopEnvironments/gnome.nix
      ./../../../systemSettings/development/programmingTools.nix
      ./../../../systemSettings/gaming/steam.nix
      ./../../../systemSettings/hardware/bluetooth.nix
      ./../../../systemSettings/hardware/graphics.nix
      ./../../../systemSettings/hardware/intel.nix
      ./../../../systemSettings/hardware/sound.nix
      ./../../../systemSettings/network/disableAvahi.nix
      ./../../../systemSettings/network/firewall.nix
      ./../../../systemSettings/network/hosts.nix
      ./../../../systemSettings/network/interfaceTools.nix
      ./../../../systemSettings/network/networkManager.nix
      ./../../../systemSettings/network/vpnClients.nix
      ./../../../systemSettings/packageManagers/nix.nix
      ./../../../systemSettings/security/securityConfig.nix
      ./../../../systemSettings/security/users.nix
      ./../../../systemSettings/shell/zsh.nix
      ./../../../systemSettings/sound/pipewire.nix
      ./../../../systemSettings/system/bluetoothClients.nix
      ./../../../systemSettings/system/bootManager.nix
      ./../../../systemSettings/system/firmwareUpdate.nix
      ./../../../systemSettings/system/fsTune.nix
      ./../../../systemSettings/system/graphicServer.nix
      ./../../../systemSettings/system/kernel.nix
      ./../../../systemSettings/system/linuxFirmwares.nix
      ./../../../systemSettings/system/powerManagement.nix
      ./../../../systemSettings/system/powerManagement.nix
      ./../../../systemSettings/system/printing.nix
      ./../../../systemSettings/system/swap.nix
      ./../../../systemSettings/system/systemInfo.nix
      ./../../../systemSettings/system/timezone.nix
      ./../../../systemSettings/system/tty.nix
      ./../../../systemSettings/virtualization/virtualbox.nix
      ./boot.nix
      ./network.nix
      ./partitions.nix
      ./amd.nix
      ./nix.nix
      ./nvidia.nix
      ./systemd.nix
    ];
}
