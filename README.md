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
- Feature: Full-disk LUKS encryption, LVM (ext4 root + swap), Lanzaboote Secure Boot

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

### Method D: `cloud0` - ASUS Vivobook (LUKS + LVM + ext4 + Secure Boot)

This method uses `disko` to automatically partition `/dev/nvme0n1` with a LUKS-encrypted LVM layout (ext4 root, 32 GB swap) and configures Secure Boot via Lanzaboote.

**Partition layout that disko creates:**

| Partition | Label | Size | Content |
|-----------|-------|------|---------|
| `/dev/nvme0n1p1` | ESP | 4 GB | vfat → `/boot/EFI` |
| `/dev/nvme0n1p2` | `cryptdisk` | Remaining | LUKS → LVM vg0 → swap (32 GB) + ext4 root |

> **Why the system hangs on boot if you skip disko:** The initrd looks for
> `/dev/disk/by-partlabel/cryptdisk` to open LUKS. If that GPT label does not
> exist the boot process will stall indefinitely. Always use disko (or create
> the partition with exactly that label manually) so the label is correct.

**WARNING:** This wipes the entire `/dev/nvme0n1` disk.

#### Phase 1 – Live environment

1.  **Boot from the NixOS minimal ISO** and open a root shell:
    ```shell
    sudo -i
    ```

2.  **Connect to the internet** (`nmtui` for Wi-Fi or automatic DHCP for Ethernet).

3.  **Enter a temporary Nix shell** with git:
    ```shell
    nix-shell -p git
    ```

4.  **Clone the repository to `/tmp`** (more space than the ISO's tmpfs):
    ```shell
    cd /tmp
    git clone https://github.com/sincorchetes/nixos-flake-hardware-profiles nixos
    cd nixos
    ```

#### Phase 2 – Partition, format and mount

5.  **Run disko** — this partitions the disk, formats both the ESP and the LUKS container, activates LVM and mounts everything under `/mnt`. You will be prompted to enter and confirm the LUKS passphrase:
    ```shell
    sudo nix run github:nix-community/disko \
      --extra-experimental-features "nix-command flakes" \
      -- --mode disko ./profiles/cloud/disko.nix
    ```

    After disko finishes, verify the mounts:
    ```shell
    mount | grep /mnt
    # Expected: /mnt (ext4), /mnt/boot/EFI (vfat)
    lsblk -o NAME,LABEL,MOUNTPOINT /dev/nvme0n1
    ```

#### Phase 3 – Installation

6.  **Create a TMPDIR on the mounted disk** to avoid running out of space in the ISO's tmpfs during the build:
    ```shell
    sudo mkdir -p /mnt/tmp
    sudo chmod 1777 /mnt/tmp
    ```

7.  **Install NixOS:**
    ```shell
    sudo TMPDIR=/mnt/tmp nixos-install --flake /tmp/nixos#cloud0
    ```

    You will be asked to set a root password at the end of the installation.

8.  **Reboot** into the newly installed system.  
    Secure Boot must be **disabled** in the UEFI firmware at this point (you will enable it later):
    ```shell
    reboot
    ```

#### Phase 4 – First boot: generate Secure Boot keys

Log in as root (or `sudo -i`) once NixOS has booted.

9.  **Generate your Secure Boot key bundle** where Lanzaboote expects it:
    ```shell
    sudo sbctl create-keys
    ```

    `sbctl` stores the keys in `/etc/secureboot/` by default, which matches `pkiBundle = "/etc/secureboot"` in the profile.

10. **Rebuild the system** so Lanzaboote signs the Unified Kernel Image (UKI) with the new keys:
    ```shell
    cd /etc/nixos   # or wherever you cloned the flake
    sudo nixos-rebuild switch --flake .#cloud0
    ```

11. **Verify that the UKI is signed correctly:**
    ```shell
    sudo sbctl verify
    ```
    Every entry listed should show `OK`.

#### Phase 5 – Enroll keys into the UEFI firmware

12. **Reboot into the UEFI/BIOS** setup screen.

13. Navigate to the **Secure Boot** section and choose **"Reset to Setup Mode"** (also called "Clear Secure Boot Keys" on some firmware). Save and exit — the laptop will boot NixOS again.

14. **Enroll your keys**, including Microsoft's UEFI CA so that any Microsoft-signed firmware (e.g. BIOS updates, Option ROMs) continues to work:
    ```shell
    sudo sbctl enroll-keys -m
    ```

15. **Reboot into the UEFI/BIOS** one final time and **enable Secure Boot**. The firmware should now show **"User Mode"** (not "Setup Mode"). Save and exit.

16. NixOS will boot normally with Secure Boot active. Confirm with:
    ```shell
    bootctl status | grep "Secure Boot"
    # Should show: Secure Boot: enabled (user)
    ```
