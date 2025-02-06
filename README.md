# Hardware Profiles
## ThinkPad X270
- CPU: Intel i5-6300U
- GPU: Intel Skylake GT2 [HD Graphics 520]
- RAM: 32GB

## HP ProBook 440 G8 PC/8A74
- CPU: Intel i7-1165G7
- GPU: Intel TigerLake-LP GT2 [Iris Xe Graphics]
- RAM: 16GB

## Custom CPU Hardware
- CPU: AMD Ryzen 7 7800X3D
- GPU: NVIDIA GeForce RTX 4060 Ti TWIN EDGE 16GB GDDR6 DLSS3
- PSU: Forgeon Bolt PSU 850W 80+ Gold Full Modular
- Cooling System: Corsair iCUE H100i RGB ELITE 240mm
- Chassis: Corsair iCUE 4000D RGB AIRFLOW USB 3.2
- Motherboard: ASUS TUF GAMING X870-PLUS WIFI
- RAM: Corsair Vengeance DDR5 6400MHz 64GB (2x32GB CL32)
- Storage: WD Black SN850X 2TB NVMe PCIe 4.0 M.2 Gen4 16GT/s
- Keyboard/Mouse: Logitech MK295

# Setup Guide
1. Format the USB drive with the latest nixOS minimal setup
   `sudo cp nixos-minimal*.iso /dev/sdX`
2. You should restart the computer, enter the BIOS/UEFI, and boot from the USB.
3. Init network
   - Wireless mode
     1. Check your Wireless NIC: `ip addr |grep 'wl'` (_for me wlp3s0_).
     2. Set password file: `wpa_passphrase WLAN_XXX SDflsñdjfp3ur > wireless.config`
     3. Stablish connection: `sudo wpa_supplicant -i wlp3s0 -c wireless.config &`
   - Ethernet (plug-in for DHCP).
4. Create a partition disk, and partitions, in my case `/ and /boot`. I don't need more.
   ```shell
   sudo fdisk /dev/nvme0n1
   sudo mkfs.fat -F 32 /dev/nvme0n1p1
   sudo cryptsetup luksFormat /dev/nvme0n1p2
   sudo cryptsetup luksOpen /dev/nvme0n1p2 nix-root
   sudo mkfs.ext4 /dev/mapper/nixos-root
   ```
5. Mounting filesystems
   ```shell
   sudo mount /dev/mapper/nixos-root /mnt
   sudo mkdir /mnt/boot
   sudo mount /dev/nvme0n1p1 /mnt/boot
   ```
6. Generate nixos configuration to get partition scheme
   `sudo nixos-generate-config --root /mnt/`
7. Copy `hardware-configuration.nix` in `/home/nixos`.
   `cp /mnt/etc/nixos/hardware-configuration.nix $HOME`
9. Remove the files in `/mnt/etc/nixos`
   `sudo rm -rf /mnt/etc/nixos`
10. Clone the repository
    ```shell
    nix-shell -p git
    sudo git clone https://github.com/sincorchetes/nixos-flake-hardware-profiles /mnt/etc/nixos
    ```
11. Get the partition's ID from `/home/nixos/hardware-configuration.nix` and replace it in `machine/partitions.nix` and `machine/boot.nix` files.
12. Enable flakes: `export NIX_CONFIG="extra-experimental-features = nix-command flakes"`
14. Setup the system: `sudo nixos-install --flake /mnt/etc/nixos#thinkpad0`
15. Set the root password and reboot the system
