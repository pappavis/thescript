#!/bin/bash
LOGFILE="/home/pi/logs/installDesktop.txt"

echo "** installeer minimale Raspbian desktop." 2>&1 | tee -a $LOGFILE



if [ "$(id -u)" != "0" ]
then
  echo "Draai deze scriptje als gebruikter root" 2>&1
  echo "Aangezien ons 'n paar pakkete moet installeer, sudo" 2>&1
  echo "wordt WEL gebruikt. Dankie :)" 2>&1
  #exit 1
fi


echo
echo "This will install the desktop environment on your Pi" 2>&1 | tee -a $LOGFILE
echo "Please keep in mind that the desktop environment needs" 2>&1 | tee -a $LOGFILE
echo "system resources that then might not be available for" 2>&1 | tee -a $LOGFILE
echo "printing, possible leading to print artifacts." 2>&1 | tee -a $LOGFILE
echo "It is not recommended to run the desktop environment" 2>&1 | tee -a $LOGFILE
echo "alongside OctoPrint if you do not have a Pi with" 2>&1 | tee -a $LOGFILE
echo "multiple cores (e.g. Pi1 or PiZero). Even then, use" 2>&1 | tee -a $LOGFILE
echo "at your own risk." 2>&1 | tee -a $LOGFILE


sudo apt update -y

for addonnodes in raspberrypi-ui-mods xinit xserver-xorg xrdp   ; do
  echo " "
  echo " "
  echo "Installeren desktop: ${addonnodes}" 2>&1 | tee -a $LOGFILE
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

x_on_boot="yes"

if [ "$x_on_boot" == "yes" ]
then
  echo
  echo "--- Setting up Pi to boot to desktop" 2>&1 | tee -a $LOGFILE
  echo
  systemctl set-default graphical.target 2>&1 | tee -a $LOGFILE
else
  echo
  echo "--- Setting up Pi to not boot to desktop" 2>&1 | tee -a $LOGFILE
  echo
  systemctl set-default multi-user.target 2>&1 | tee -a $LOGFILE
fi


echo 2>&1 | tee -a $LOGFILE
echo "--- Done!" 2>&1 | tee -a $LOGFILE
echo 2>&1 | tee -a $LOGFILE

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
for addonnodes in remmina barrier thonny kodi chromium code tightvncserver audacity rpi-imager piclone guvcview gparted rpi-imager mozilla-thunderbird kmail; do
  echo "Installeren desktop app ${addonnodes}" 2>&1 | tee -a $LOGFILE
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo adduser xrdp ssl-cert  2>&1 | tee -a $LOGFILE
systemctl show -p SubState --value xrdp 2>&1 | tee -a $LOGFILE
echo "minimale Raspbian desktop installatie afgerond" 2>&1 | tee -a $LOGFILE
