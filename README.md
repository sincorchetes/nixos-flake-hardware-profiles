# Hardware Profiles
## ThinkPad X270
- CPU: Intel i5-6300U
- GPU: Intel Skylake GT2 [HD Graphics 520]
- RAM: 32GB
- Desktop Environment: XFCE (lightweight)

## HP ProBook 440 G8 PC/8A74
- CPU: Intel i7-1165G7
- GPU: Intel TigerLake-LP GT2 [Iris Xe Graphics]
- RAM: 32GB

## Custom CPU Hardware
- CPU: AMD Ryzen 7 7800X3D
- GPU: NVIDIA GeForce RTX 4060 Ti TWIN EDGE 16GB GDDR6 DLSS3
- PSU: Forgeon Bolt PSU 850W 80+ Gold Full Modular
- Cooling System: Corsair iCUE H100i RGB ELITE 240mm
- Chassis: Corsair iCUE 4000D RGB AIRFLOW USB 3.2
- Motherboard: ASUS TUF GAMING X870-PLUS WIFI
- RAM: Corsair Vengeance DDR5 6400MHz 64GB (2x32GB CL32)
- Storage: WD Black SN850X 2TB NVMe PCIe 4.0 M.2 Gen4 16GT/s
- Keyboard: Keychron K3 Max
- Mouse: Keychron M6 8K Ultra

## ASUS Vivobook
- Target Profile: `cloud0`
- Feature: Shared EFI with Windows, ZFS, Lanzaboote Secure Boot

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

1.  **Clone the repository to /tmp (which has more space in the ISO):**
    ```shell
    cd /tmp
    git clone https://github.com/sincorchetes/nixos-flake-hardware-profiles nixos
    cd nixos
    ```

2.  **Partition and mount the disk with Disko:**
    ```shell
    sudo nix run github:nix-community/disko --extra-experimental-features "nix-command flakes" -- --mode disko ./profiles/tank/disko.nix
    ```

3.  **Create a temporary directory on the mounted disk (to avoid ISO tmpfs limits):**
    ```shell
    sudo mkdir -p /mnt/tmp
    sudo chmod 1777 /mnt/tmp
    ```

4.  **Run the installation with TMPDIR pointing to the mounted disk:**
    ```shell
    sudo TMPDIR=/mnt/tmp nixos-install --flake /tmp/nixos#tank0
    ```

5.  You will be prompted to enter a passphrase to encrypt the ZFS pool.

6.  After the installation is complete, set a password for the `root` user and reboot.

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

### Method C: `thinkpad-x270` - Automated Installation with Disko (ext4 + LUKS)

This method uses `disko` to automatically partition and format the disk with an encrypted ext4 filesystem, optimized for the ThinkPad X270 with the SSSTC CL1-4D256 SSD.

**WARNING:** This will destroy all data on the specified disk (`/dev/sda`).

1.  **Clone the repository to /tmp (which has more space in the ISO):**
    ```shell
    cd /tmp
    git clone https://github.com/sincorchetes/nixos-flake-hardware-profiles nixos
    cd nixos
    ```

2.  **Partition and mount the disk with Disko:**
    ```shell
    sudo nix run github:nix-community/disko --extra-experimental-features "nix-command flakes" -- --mode disko ./profiles/thinkpad-x270/disko.nix
    ```

3.  **Create a temporary directory on the mounted disk (to avoid ISO tmpfs limits):**
    ```shell
    sudo mkdir -p /mnt/tmp
    sudo chmod 1777 /mnt/tmp
    ```

4.  **Run the installation with TMPDIR pointing to the mounted disk:**
    ```shell
    sudo TMPDIR=/mnt/tmp nixos-install --flake /tmp/nixos#thinkpad-x270
    ```

5.  You will be prompted to enter a passphrase to encrypt the root partition.

6.  After the installation is complete, set a password for the `root` user and reboot.

### Method D: `cloud0` - ASUS Vivobook (Manual ZFS + Secure Boot)

This method covers the installation for the `cloud0` profile. It involves manual ZFS partitioning (to share a drive safely with Windows) and configuring Secure Boot using Lanzaboote with Microsoft keys included.

1.  **Create the ZFS Pool manually:**
    *   Identify your target partition (e.g., using `partlabel`).
    ```shell
    sudo zpool create -f -O encryption=aes-256-gcm -O keyformat=passphrase -O keylocation=prompt -O compression=lz4 -O xattr=sa -O atime=off -O acltype=posixacl rpool /dev/disk/by-partlabel/zfs
    ```

2.  **Create ZFS Datasets:**
    ```shell
    sudo zfs create -p -o mountpoint=legacy rpool/local/root
    sudo zfs create -p -o mountpoint=legacy -o atime=off rpool/local/nix
    sudo zfs create -p -o mountpoint=legacy -o recordsize=128K rpool/local/docker
    sudo zfs create -p -o mountpoint=legacy rpool/safe/home
    sudo zfs create -p -o mountpoint=legacy -o atime=off -o com.sun:auto-snapshot=false rpool/safe/home/sincorchetes/.cache
    ```

3.  **Mount Filesystems:**
    ```shell
    sudo mount -t zfs rpool/local/root /mnt
    sudo mkdir -p /mnt/{nix,home,var/lib/docker,boot}
    sudo mount -t zfs rpool/local/nix /mnt/nix
    sudo mount -t zfs rpool/safe/home /mnt/home
    sudo mount -t zfs rpool/local/docker /mnt/var/lib/docker
    
    # Mount the shared Windows EFI partition
    sudo mount /dev/disk/by-partlabel/disk-main-ESP /mnt/boot
    ```

4.  **Run the installation:**
    ```shell
    sudo nixos-install --flake .#cloud0
    ```

5.  **Reboot and Configure Secure Boot (Post-Install):**
    *   Reboot into the newly installed system (Secure Boot should be disabled in BIOS at this point).
    *   Generate your Secure Boot keys and place them where Lanzaboote expects them:
    ```shell
    sudo sbctl create-keys --export /etc/secureboot
    sudo mkdir -p /etc/secureboot/keys
    sudo mv /etc/secureboot/{db,KEK,PK} /etc/secureboot/keys/
    ```
    *   Apply the configuration so Lanzaboote builds and signs your Unified Kernel Image (UKI):
    ```shell
    sudo nixos-rebuild switch --flake .#cloud0
    ```

6.  **Enroll Keys into the Motherboard:**
    *   Reboot your laptop and enter the UEFI/BIOS.
    *   Go to the Secure Boot section and select **"Reset to Setup Mode"** (or "Clear Secure Boot Keys").
    *   Save changes and boot NixOS again.
    *   Enroll your new custom keys, **ensuring you include Microsoft's keys** (`-m`) so Windows continues to boot:
    ```shell
    sudo sbctl enroll-keys -m
    ```

7.  **Finalize:**
    *   Reboot into BIOS one last time.
    *   Enable Secure Boot (it should now display "User Mode").
    *   Save and exit. Your dual-boot system is now fully secured.
