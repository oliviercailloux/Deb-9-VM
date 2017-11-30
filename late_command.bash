#!/usr/bin/env bash

exec > >(tee -ia /root/late_command-out.txt)
exec 2> >(tee -ia /root/late_command-errors.txt >&2)

cd /root

ls -l /home /media /media/cdrom /media/cdrom0 /media/cdrom1 /media/cdrom2 /mnt

sed -i "s/^#  \(AutomaticLoginEnable = true\)$/\1/" /etc/gdm3/daemon.conf
sed -i "s/^#  \(AutomaticLogin = user1\)$/AutomaticLogin = user/" /etc/gdm3/daemon.conf

mount /dev/sr1 /media/cdrom1
/media/cdrom1/VBoxLinuxAdditions.run --nox11

sed -i "s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/" /etc/default/grub
update-grub

sed -i 's/XKBVARIANT="latin9"/XKBVARIANT="oss_sundeadkeys"/' /etc/default/keyboard
#sed -i 's/XKBLAYOUT="fr"/XKBLAYOUT="be"/' /etc/default/keyboard

wget --progress=dot:mega http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/oxygen/1a/eclipse-jee-oxygen-1a-linux-gtk-x86_64.tar.gz
tar -x -f eclipse-jee-oxygen-1a-linux-gtk-x86_64.tar.gz -C /usr/local/share/
rm eclipse-jee-oxygen-1a-linux-gtk-x86_64.tar.gz
chgrp -R staff /usr/local/share/eclipse
chmod -R g+w /usr/local/share/eclipse
ln -s /usr/local/share/eclipse/eclipse /usr/local/bin
/usr/local/share/eclipse/eclipse -nosplash -application org.eclipse.equinox.p2.director -repository "http://download.eclipse.org/releases/oxygen/,http://download.oracle.com/otn_software/oepe/12.2.1.6/oxygen/repository" -installIU oracle.eclipse.tools.glassfish.feature.group
xdg-icon-resource install --size 256 /usr/local/share/eclipse/icon.xpm eclipse-oxygen
xdg-desktop-menu install "/media/cdrom/eclipse-oxygen.desktop"
su user -c 'mkdir -p /home/user/.eclipse/org.eclipse.platform_4.7.1_1591644777_linux_gtk_x86_64/configuration/.settings/'
su user -c 'echo "SHOW_WORKSPACE_SELECTION_DIALOG=false" > /home/user/.eclipse/org.eclipse.platform_4.7.1_1591644777_linux_gtk_x86_64/configuration/.settings/org.eclipse.ui.ide.prefs'

wget --progress=dot:mega http://download.java.net/glassfish/4.1.2/release/glassfish-4.1.2.zip
unzip -q glassfish-4.1.2.zip -d /usr/local/share/
rm glassfish-4.1.2.zip
chown -R user:staff /usr/local/share/glassfish4
chmod -R g+w /usr/local/share/glassfish4
echo 'java -jar "/usr/local/share/glassfish4/glassfish/lib/client/appserver-cli.jar" "$@"' > /usr/local/bin/asadmin
chmod a+x /usr/local/bin/asadmin
su user -c '/usr/local/bin/asadmin start-domain'
su user -c '/usr/local/bin/asadmin set server-config.network-config.network-listeners.network-listener.admin-listener.address=localhost'
su user -c '/usr/local/bin/asadmin set server-config.network-config.network-listeners.network-listener.http-listener-1.address=localhost'
su user -c '/usr/local/bin/asadmin set server-config.network-config.network-listeners.network-listener.http-listener-2.enabled=false'

su user -c 'xdg-user-dirs-update --set DESKTOP "$HOME"'
su user -c 'xdg-user-dirs-update --set TEMPLATES "$HOME"'
su user -c 'xdg-user-dirs-update --set DOCUMENTS "$HOME"'
su user -c 'xdg-user-dirs-update --set MUSIC "$HOME"'
su user -c 'xdg-user-dirs-update --set PICTURES "$HOME"'
su user -c 'xdg-user-dirs-update --set VIDEOS "$HOME"'

su user -c "gsettings set org.gnome.nautilus.list-view default-zoom-level small"
su user -c "gsettings set org.gnome.nautilus.preferences default-folder-viewer list-view"

su user -c "gsettings set org.gnome.desktop.screensaver lock-enabled false"
su user -c "gsettings set org.gnome.desktop.session idle-delay 0"

#su user -c "cd ; git clone https://github.com/oliviercailloux/samples.git"
#su user -c "cd ; wget https://raw.githubusercontent.com/oliviercailloux/java-course/master/Best%20practices/Eclipse-prefs.epf"

