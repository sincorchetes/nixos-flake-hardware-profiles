{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       virtiofsd
       libvirt
       qemu_kvm
       virt-manager
       spice-gtk
       virtio-win
       virglrenderer
       OVMF
       (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
       '')
    ];
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };
  };

  users = {
    users = {
      sincorchetes = {
        extraGroups = ["libvirtd" "kvm"];
      };
    };
  };
}
