#!/bin/bash

echo "Set time"
timedatectl set-ntp true

echo "Partition"
read -r -p "/dev/sdX:" drive
sudo cfdisk $drive

echo "Format Mount"
read -r -p "choose you root partition, /dev/sdXn(eg:/dev/sda2)" rootp
mkfs.ext4 $rootp
mount $rootp /mnt
read -r -p "choose you boot partition, /dev/sdXn(eg:/dev/sda1)" bootp
mkdir /mnt/boot
mkfs.fat -F32 $bootp
mount $bootp /mnt/boot
read -r -p "choose you home partition, /dev/sdXn(eg:/dev/sda3)" homep
mkdir /mnt/home
mkfs.ext4 $homep
mount $homep /mnt/home

echo "Change Source"
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
touch /etc/pacman.d/mirrorlist
echo "Server = https://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
pacman -Syy

echo "Pacstrap"
pacstrap /mnt base base-devel linux linux-firmware nano grub efibootmgr networkmanager intel-ucode
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

echo "Locale setting"
arch-chroot /mnt bash -c "ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && hwclock --systohc sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen && echo 'LANG=en_US.UTF-8' > /etc/locale.conf && exit"

echo "Set hostname: arch"
arch-chroot /mnt bash -c "echo arch > /etc/hostname && echo 127.0.0.1 localhost  > /etc/hosts && echo ::1 localhost  >> /etc/hosts && echo 127.0.1.1 arch.localdomain arch >> /etc/hosts && exit"

echo "Set root password and adduser hai"
arch-chroot /mnt bash -c "echo 'set root passwd' && passwd && useradd -mG wheel hai && echo 'set hai password' && passwd hai && EDITOR=nano visudo && exit"

echo "Enable services"
arch-chroot /mnt bash -c "systemctl enable NetworkManager && exit"

echo "UEFI grub install"
arch-chroot /mnt bash -c "grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB && grub-mkconfig -o /boot/grub/grub.cfg && exit"

# umount
umount -r /mnt

echo "Done! Move CD! Reboot!"
