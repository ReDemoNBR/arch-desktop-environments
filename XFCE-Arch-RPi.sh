echo "Run this script as root only."
echo "You can hit Ctrl+c in next 10 seconds if you don't want to continue."
sleep 10
# initialize pacman keys
pacman-key --init
# update system
pacman -Syu --noconfirm
# install base packages
pacman -S --noconfirm --needed base base-devel yajl wget
# install X.org
pacman -S --noconfirm xorg-xinit xorg-server xorg-server-utils xterm
# install Xfce4 desktop environment
pacman -S --noconfirm xfce4 xfce4-goodies
# install video and audio
pacman -S --noconfirm mesa xf86-video-fbdev xf86-video-vesa pulseaudio pulseaudio-alsa
# install LightDM display manager
pacman -S --noconfirm lightdm lightdm-gtk-greeter
systemctl enable lightdm.service
systemctl enable graphical.target
# enable DHCPCD
systemctl enable dhcpcd

# create 2GB swapfile in /swapfile
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo /swapfile none swap defaults 0 0 | tee -a /etc/fstab

curl https://raw.github.com/ReDemoNBR/arch-desktop-environments/master/xinitrc >> ~/.xinitrc
curl https://raw.github.com/ReDemoNBR/arch-desktop-environments/master/bash_profile >> ~/.bash_profile

reboot
