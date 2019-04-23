#!/usr/bin/bash
echo "Welcome to installing Mobile office terminal"
echo "GNU General Public License."
apt-get update
apt-get install zenity openbox xinit freerdp -y
sed -i 's/ExecStart=-\/sbin\/agetty --noclear %I $TERM/ExecStart=-\/sbin\/agetty --autologin root --noclear %I $TERM/' /etc/systemd/system/getty.target.wants/getty@tty1.service
mkdir -p ~/.config/openbox/autostart
touch ~/.config/openbox/start.bash
touch ~/.bash_profile
echo -e "#!/usr/bin/bash" >> ~/.config/openbox/start.bash
echo -e "while true; do" >> ~/.config/openbox/start.bash
echo -e "login=\`zenity --password --username\`" >> ~/.config/openbox/start.bash
echo -e "log=\`echo \$login |cat -d\| -f1\`" >> ~/.config/openbox/start.bash
echo -e "pass=\`echo \$login |cat -d\| -f2\`" >> ~/.config/openbox/start.bash
echo -e "address=\"192.168.0.31\"" >> ~/.config/openbox/start.bash
echo -e "xfreerdp /f /u:\$log /p:\$pass /v:\$address /d:corporate /cert-ignore" >> ~/.config/openbox/start.bash
echo -e "done" >> ~/.config/openbox/start.bash
echo -e "startx" >> ~/.bash_profile
reboot
