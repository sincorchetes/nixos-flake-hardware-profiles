{ config, lib, pkgs, ... }:

{
  # System Packages Default Will Be Installed
  system.stateVersion = "24.11";
  environment = {
    systemPackages = with pkgs; [
       vmware-workstation
       docker
       xdg-utils
       glib
       pritunl-client
       pciutils
       linux-firmware
       fwupd
       fwupd-efi
       bridge-utils
       linux-firmware
       zsh
       zsh-syntax-highlighting
       zsh-autosuggestions
       zsh-powerlevel10k
       vscode.fhs
       virtiofsd
       libvirt
       kitty
       qemu_kvm
       waybar
       inetutils
       OVMF
       xboxdrv
       heroic
       #unstablePkgs.bluez
       gnome-network-displays
       (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
    ];
  };
}
