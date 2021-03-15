#!/bin/bash
echo "Connect wifi"
nmtui
sudo pacman -Syyu
sudo sh -c "echo [archlinuxcn] >> /etc/pacman.conf"
sudo sh -c "echo 'Server = https://mirrors.ustc.edu.cn/archlinuxcn/\$arch' >> /etc/pacman.conf"
sudo pacman -Syy
sudo pacman -S archlinuxcn-keyring
sudo pacman -S xorg xorg-xinit xf86-video-intel bspwm sxhkd dmenu xfce4-terminal nitrogen picom firefox pulseaudio pavucontrol xdg-user-dirs rsync gimp virtualbox obs-studio neofetch pcmanfm fcitx-im fcitx-rime fcitx-configtool git smplayer lxsession lxappearance emacs sxiv filezilla alsa-utils alsa-plugins rsync fish keepassxc pulseaudio-alsa ufw polybar ttf-font-awesome v2ray qv2ray python python3 fava annie ffmpeg arc-gtk-theme arc-icon-theme flameshot linux-headers openssh qbittorrent deadbeef libmad audacity qt5ct hdparm tldr nutstore nfs-utils ventoy code atril pandoc
