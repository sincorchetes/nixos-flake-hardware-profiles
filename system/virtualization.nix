{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    spice-gtk
    virtio-win
    virglrenderer
    OVMF
  ];
}