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

This guide provides instructions for installing NixOS using the configurations in this repository.

## 1. Initial Live Environment Setup

These steps are common for all installation types.

1.  **Create a bootable USB drive** with the latest NixOS minimal installer.
    ```shell
    sudo cp nixos-minimal-*.iso /dev/sdX
    ```
2.  **Boot from the USB drive** and switch to a root shell.
    ```shell
    sudo -i
    ```
3.  **Connect to the internet.**
    *   For Wi-Fi, use `nmtui`.
    *   For Ethernet, it should connect automatically via DHCP.
4.  **Enter a Nix shell** with `git` to clone the repository.
    ```shell
    nix-shell -p git
    ```

## 2. Installation Methods

Choose one of the following methods based on your target machine.

### Method A: `tank0` - Automated Installation with Disko (Wipes Disk)

This method uses `disko` to automatically partition and format an entire disk with an encrypted ZFS filesystem.

**WARNING:** This will destroy all data on the specified disk (`/dev/nvme0n1`).

1.  **Clone the repository:**
    ```shell
    git clone https://github.com/sincorchetes/nixos-flake-hardware-profiles /mnt/etc/nixos
    ```
2.  **Run the installation (this will execute the Disko configuration):**
    ```shell
    nixos-install --flake /mnt/etc/nixos#tank0
    ```
3.  You will be prompted to enter a passphrase to encrypt the ZFS pool.
4.  After the installation is complete, set a password for the `root` user and reboot.

### Method B: `probook` - Manual ZFS for Dual Boot with Windows

This method is for installing NixOS alongside an existing Windows installation. It requires manual partitioning and ZFS pool creation.

1.  **Manual Partitioning:**
    *   Use a partitioning tool like `gparted` (you may need to install it with `nix-shell -p gparted`) or `fdisk` to shrink your Windows partition and create a new partition for NixOS.
    *   Leave the newly created space unformatted. Let's assume the new partition is `/dev/nvme0n1p3`.

2.  **Create the ZFS Pool:**
    *   Identify the partition you created (e.g., `/dev/nvme0n1p3`).
    *   Create the encrypted ZFS pool (`rpool`) on this partition. Add any specific optimizations you require.
    ```shell
    zpool create -p \
        -O encryption=aes-256-gcm \
        -O keyformat=passphrase \
        -O acltype=posixacl \
        -O xattr=sa \
        -O dnodesize=auto \
        -O atime=off \
        -O compression=lz4 \
        -o ashift=12 \
        -o autotrim=on \
        -R /mnt \
        rpool \
        /dev/nvme0n1p3
    ```

3.  **Create ZFS Datasets:**
    *   Create the datasets as defined in the `probook` profile.
    ```shell
    # Root and Nix datasets
    zfs create -o mountpoint=legacy rpool/local/root
    zfs create -o mountpoint=legacy rpool/local/nix
    
    # Home and user-specific datasets
    zfs create -o mountpoint=legacy rpool/safe/home
    zfs create -o mountpoint=legacy rpool/safe/home/sincorchetes
    zfs create -o mountpoint=legacy -o com.sun:auto-snapshot=false rpool/safe/home/sincorchetes/.cache

    # Datasets for services
    zfs create -o mountpoint=legacy rpool/local/vms
    zfs create -o mountpoint=legacy rpool/local/docker

    # Mount the root dataset
    mount -t zfs rpool/local/root /mnt
    ```

4.  **Mount other filesystems:**
    *   Mount the other datasets and the EFI partition (which should already exist from the Windows installation).
    ```shell
    mkdir -p /mnt/nix /mnt/home /mnt/home/sincorchetes /mnt/home/sincorchetes/.cache /mnt/var/lib/libvirt/images /mnt/var/lib/docker /mnt/boot
    mount -t zfs rpool/local/nix /mnt/nix
    mount -t zfs rpool/safe/home /mnt/home
    mount -t zfs rpool/safe/home/sincorchetes /mnt/home/sincorchetes
    mount -t zfs rpool/safe/home/sincorchetes/.cache /mnt/home/sincorchetes/.cache
    mount -t zfs rpool/local/vms /mnt/var/lib/libvirt/images
    mount -t zfs rpool/local/docker /mnt/var/lib/docker
    ```
    Find your EFI partition, usually the first one. e.g. /dev/nvme0n1p1
    ```
    mount /dev/nvme0n1p1 /mnt/boot
    ```
    
5.  **Clone the repository:**
        ```shell
        git clone https://github.com/sincorchetes/nixos-flake-hardware-profiles /mnt/etc/nixos
        ```
6.  **Run the installation:**
        ```shell
        nixos-install --flake /mnt/etc/nixos#probook0
        ```
7.  Set the system partition
    ```shell
    zpool get bootfs tank
    sudo zpool set bootfs=tank/root tank
    ```
8.  After the installation is complete, set a password for the `root` user and reboot.
