#!/usr/bin/env bash

exec > >(tee -ia /root/late_command-out.txt)
exec 2> >(tee -ia /root/late_command-errors.txt >&2)

cd /root

ls /home /media /mnt

sed -i "s/^#  \(AutomaticLoginEnable = true\)$/\1/" /etc/gdm3/daemon.conf
sed -i "s/^#  \(AutomaticLogin = user1\)$/AutomaticLogin = user/" /etc/gdm3/daemon.conf

mkdir vbox
mount /dev/sr1 vbox
vbox/VBoxLinuxAdditions.run --nox11

sed -i "s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/" /etc/default/grub
update-grub

sed -i 's/XKBVARIANT="latin9"/XKBVARIANT="oss_sundeadkeys"/' /etc/default/keyboard
sed -i 's/XKBLAYOUT="fr"/XKBLAYOUT="be"/' /etc/default/keyboard

wget http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/oxygen/1a/eclipse-jee-oxygen-1a-linux-gtk-x86_64.tar.gz
tar -x -f eclipse-jee-oxygen-1a-linux-gtk-x86_64.tar.gz -C /usr/local/share/
ln -s /usr/local/share/eclipse/eclipse /usr/local/bin
/usr/local/share/eclipse/eclipse -nosplash -application org.eclipse.equinox.p2.director -repository "http://download.eclipse.org/releases/oxygen/,http://download.oracle.com/otn_software/oepe/12.2.1.6/oxygen/repository" -installIU oracle.eclipse.tools.glassfish.feature.group
xdg-icon-resource install --size 256 /usr/local/share/eclipse/icon.xpm eclipse-oxygen
xdg-desktop-menu install "/media/cdrom/eclipse-oxygen.desktop"

gsettings get org.gnome.desktop.screensaver lock-enabled
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings get org.gnome.desktop.screensaver lock-enabled

