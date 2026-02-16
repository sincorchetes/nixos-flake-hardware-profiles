{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm; 
      swtpm.enable = true;
      ovmf.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ]; 
      vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };

  users.users.sincorchetes.extraGroups = [ "libvirtd" "kvm" ];

  environment.systemPackages = with pkgs; [
    virt-manager 
    spice-gtk    
    virtio-win   
    virglrenderer
  ];
}