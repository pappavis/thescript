LOGFILE="/home/pi/logs/installDesktop.txt"

echo "** installeer minimale Raspbian desktop." 2>&1 | tee -a $LOGFILE
for addonnodes in raspberrypi-ui-mods xinit xserver-xorg xrdp   ; do
  echo " "
  echo " "
  echo "Installeren: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo mkdir /home/pi/.local
sudo mkdir /home/pi/.local/share
sudo mkdir /home/pi/.local/share/lxsession
sudo mkdir /home/pi/.local/share/lxterminal

echo  "Set de  screensaver uit"  2>&1 | tee -a $LOGFILE
sudo sed -i -e 'xserver-command xserver-command=X -s 0 -p 0 -dpms' /etc/lightdm/lightdm.conf
sed -i -e '/timeout:\t0:10:00/s/:10:/:2048:/' /home/pi/.xscreensaver
sed -i -e '/cycle:\t0:10:00/s/:10:/:1021:/' /home/pi/.xscreensaver
#xset s 0
xset -dpms



echo "** installeer X-Apps zoals KVM." 2>&1 | tee -a $LOGFILE
for addonnodes in raspberrypi-ui-mods xinit xserver-xorg xrdp  ; do
  echo " "
  echo " "
  echo "Installeren desktop ${addonnodes}" 2>&1 | tee -a $LOGFILE
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in remmina barrier thonny kodi chromium code tightvncserver audacity rpi-imager piclone guvcview gparted rpi-imager mozilla-thunderbird kmail; do
  echo "Installeren desktop app ${addonnodes}" 2>&1 | tee -a $LOGFILE
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo adduser xrdp ssl-cert  2>&1 | tee -a $LOGFILE
systemctl show -p SubState --value xrdp 2>&1 | tee -a $LOGFILE
echo "minimale Raspbian desktop installatie afgerond" 2>&1 | tee -a $LOGFILE
