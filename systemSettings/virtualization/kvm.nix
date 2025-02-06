{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = with pkgs; [
       virtiofsd
       libvirt
       qemu_kvm
       virt-manager
       spice-gtk
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
    };
  };

  users = {
    users = {
      sincorchetes = {
        extraGroups = ["libvirtd"];
      };
    };
  };
}
