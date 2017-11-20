cd /root
ls / /home /media /mnt > listall 2>> late_command-errors.txt
ls / /home /media /mnt > listall-local 2>> late_command-errors-local.txt

sed -i "s/^#  \(AutomaticLoginEnable = true\)$/\1/" /etc/gdm3/daemon.conf 1>> late_command-out.txt 2>> late_command-errors.txt
sed -i "s/^#  \(AutomaticLogin = user1\)$/AutomaticLogin = user/" /etc/gdm3/daemon.conf 1>> late_command-out.txt 2>> late_command-errors.txt

mkdir vbox 1>> late_command-out.txt 2>> late_command-errors.txt
mount /dev/sr1 vbox 1>> late_command-out.txt 2>> late_command-errors.txt
vbox/VBoxLinuxAdditions.run --nox11 1>> late_command-out.txt 2>> late_command-errors.txt

sed -i "s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/" /etc/default/grub 1>> late_command-out.txt 2>> late_command-errors.txt
update-grub 1>> late_command-out.txt 2>> late_command-errors.txt


