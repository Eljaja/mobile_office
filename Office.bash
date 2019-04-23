#!/usr/bin/bash
echo "Welcome to installing Mobile office terminal"
echo "GNU General Public License."
echo "Enter a valid IP adress for terminal server"
read addr
apt-get update
apt-get install zenity openbox xinit freerdp -y
sed -i 's/ExecStart=-\/sbin\/agetty --noclear %I $TERM/ExecStart=-\/sbin\/agetty --autologin root --noclear %I $TERM/' /etc/systemd/system/getty.target.wants/getty@tty1.service
mkdir -p ~/.config/openbox/
touch ~/.config/openbox/autostart
touch ~/.bash_profile
echo -e "#!/usr/bin/bash" >> ~/.config/openbox/autostart
echo -e "while true; do" >> ~/.config/openbox/autostart
echo -e "login=\`zenity --password --username\`" >> ~/.config/openbox/autostart
echo -e "log=\`echo \$login |cut -d\| -f1\`" >> ~/.config/openbox/autostart
echo -e "pass=\`echo \$login |cut -d\| -f2\`" >> ~/.config/openbox/autostart
echo -e "address=\"$addr\"" >> ~/.config/openbox/autostart
echo -e "xfreerdp /f /u:\$log /p:\$pass /v:\$address /d:corporate /cert-ignore" >> ~/.config/openbox/autostart
echo -e "done" >> ~/.config/openbox/autostart
echo -e "startx" >> ~/.bash_profile
reboot
