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
for addonnodes in remmina barrier thonny kodi chromium code tightvncserver audacity rpi-imager piclone guvcview gparted rpi-imager mozilla-thunderbird kmail firefox-esr ; do
  echo "" 2>&1 | tee -a $LOGFILE
  echo "" 2>&1 | tee -a $LOGFILE
  echo "Installeren desktop app ${addonnodes}" 2>&1 | tee -a $LOGFILE
  echo "" 2>&1 | tee -a $LOGFILE
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo adduser xrdp ssl-cert  2>&1 | tee -a $LOGFILE
systemctl show -p SubState --value xrdp 2>&1 | tee -a $LOGFILE

echo " * Installeren RPI-Clone" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
sudo git clone https://github.com/billw2/rpi-clone.git 2>&1 | tee -a $LOGFILE
cd rpi-clone
sudo cp rpi-clone /usr/local/sbin
cd ~/Downloads
sudo rm -r rpi-clone


echo "Installeren CommanderPi"  2>&1 | tee -a $LOGFILE
cd ~/Downloads
git clone https://github.com/jack477/CommanderPi 2>&1 | tee -a $LOGFILE
cd ./CommanderPi
echo "Y\n" | bash ./install.sh 2>&1 | tee -a $LOGFILE
rm -rf ./CommanderPi

cd ~/Downloads
printstatus "Installeren box86 emulatie ref--> https://pimylifeup.com/raspberry-pi-x86/" 2>&1 | tee -a $LOGFILE
for addonnodes in gcc-arm-linux-gnueabihf libc6:armhf libncurses5:armhf libstdc++6:armhf cmake ; do
  echo " "
  echo " "
  echo "Installeren box86 vereisten: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done
git clone https://github.com/ptitSeb/box86 2>&1 | tee -a $LOGFILE
cd ./box86
mkdir build
cd build
cmake .. -DRPI2=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo  2>&1 | tee -a $LOGFILE
make -j$(nproc)  2>&1 | tee -a $LOGFILE
sudo make install   2>&1 | tee -a $LOGFILE
sudo systemctl restart systemd-binfmt
sudo rm -rf ~/Downloads/box86

echo "* Installeren steampowered.com zie https://pimylifeup.com/raspberry-pi-steam-client/" 2>&1 | tee -a $LOGFILE
## java -jar nukkit.jar &
sudo apt remove -y steam-devices -y 2>&1 | tee -a $LOGFILE
for addonnodes in libappindicator1 libnm0 libtcmalloc-minimal4 steamlink ; do
  echo " "
  echo " "
  echo "Installeren steampowered vereisten: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done
#echo 'gpu_mem=128' | sudo tee -a /boot/config.txt | tee -a $LOGFILE
sudo chmod +rw /dev/uinput
sudo usermod -aG input pi 2>&1 | tee -a $LOGFILE
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/steamlink.service 2>&1 | tee -a $LOGFILE
sudo mv ./services/steamlink.service /etc/systemd/system
sudo systemctl enable steamlink.service 2>&1 | tee -a $LOGFILE
sudo systemctl disable steamlink.service 2>&1 | tee -a $LOGFILE
wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb 2>&1 | tee -a $LOGFILE
sudo dpkg -i ./steam.deb 2>&1 | tee -a $LOGFILE
sudo rm -rf ./steam.deb 2>&1 | tee -a $LOGFILE
sudo touch  /etc/profile.d/steam.sh
echo 'export STEAMOS=1' | sudo tee -a /etc/profile.d/steam.sh 2>&1 | tee -a $LOGFILE
echo 'export STEAM_RUNTIME=1' | sudo tee -a /etc/profile.d/steam.sh
sudo service steamlink status 2>&1 | tee -a $LOGFILE

echo "** installeer OBS Studio op pi" 2>&1 | tee -a $LOGFILE
cd~/Downloads
# https://raspberrytips.com/install-obs-studio-raspberry-pi/
for addonnodes in build-essential checkinstall cmake git libmbedtls-dev libasound2-dev libavcodec-dev libavdevice-dev libavfilter-dev libavformat-dev libavutil-dev libcurl4-openssl-dev libfontconfig1-dev libfreetype6-dev libgl1-mesa-dev libjack-jackd2-dev libjansson-dev libluajit-5.1-dev libpulse-dev libqt5x11extras5-dev libspeexdsp-dev libswresample-dev libswscale-dev libudev-dev libv4l-dev libvlc-dev libx11-dev libx11-xcb1 libx11-xcb-dev libxcb-xinput0 libxcb-xinput-dev libxcb-randr0 libxcb-randr0-dev libxcb-xfixes0 libxcb-xfixes0-dev libx264-dev libxcb-shm0-dev libxcb-xinerama0-dev libxcomposite-dev libxinerama-dev pkg-config python3-dev qtbase5-dev libqt5svg5-dev swig libwayland-dev qtbase5-private-dev ; do
  echo " "
  echo " "
  echo "Installeren OBS STudio vereisten: ${addonnodes}" 2>&1 | tee -a $LOGFILE
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done
wget http://ftp.debian.org/debian/pool/non-free/f/fdk-aac/libfdk-aac2_2.0.1-1_armhf.deb 2>&1 | tee -a $LOGFILE
wget http://ftp.debian.org/debian/pool/non-free/f/fdk-aac/libfdk-aac-dev_2.0.1-1_armhf.deb 2>&1 | tee -a $LOGFILE
sudo dpkg -i libfdk-aac2_2.0.1-1_armhf.deb 2>&1 | tee -a $LOGFILE
sudo dpkg -i libfdk-aac-dev_2.0.1-1_armhf.deb 2>&1 | tee -a $LOGFILE
sudo git clone --recursive https://github.com/obsproject/obs-studio.git
cd obs-studio
sudo mkdir build
cd build
sudo cmake -DUNIX_STRUCTURE=1 -DCMAKE_INSTALL_PREFIX=/usr -DENABLE_PIPEWIRE=OFF -DBUILD_BROWSER=OFF .. 2>&1 | tee -a $LOGFILE
sudo make -j1 2>&1 | tee -a $LOGFILE
sudo make install 2>&1 | tee -a $LOGFILE
echo MESA_GL_VERSION_OVERRIDE="3.3 obs"| sudo tee -a /etc/bash.bashrc
rm -rf ./libfdk-aac2_2.0.1-1_armhf.deb
rm -rf ,.libfdk-aac-dev_2.0.1-1_armhf.deb
echo "**  OBS Studio build afgerond" 2>&1 | tee -a $LOGFILE
echo "---------" 2>&1 | tee -a $LOGFILE

cd ~/Downloads
appTxt1="Milkytracker"
echo "" 2>&1 | tee -a $LOGFILE
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
for addonnodes in libjack-dev liblhasa-dev librtmidi-dev libsdl2-dev libzzip-dev ; do
  echo " "
  echo " "
  echo "Installeren $appTxt1 vereisten: ${addonnodes}" 2>&1 | tee -a $LOGFILE
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done
git clone https://github.com/milkytracker/MilkyTracker 2>&1 | tee -a $LOGFILE
cd ./MilkyTracker
mkdir ./build
cd ./build
cmake .. 2>&1 | tee -a $LOGFILE
make 2>&1 | tee -a $LOGFILE
sudo make install 2>&1 | tee -a $LOGFILE
cd ~/Downloads
sudo rm -rf ./MilkyTracker
echo "Einde $appTxt1 build install" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

cd ~/Downloads
appTxt1="FlatCam PCB router voor KiCAD"
echo "" 2>&1 | tee -a $LOGFILE
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
for addonnodes in pyqt6  geos  spatialindex ; do
  echo " "
  echo " "
  echo "Installeren $appTxt1 vereisten: ${addonnodes}" 2>&1 | tee -a $LOGFILE
  pip install --upgrade  2>&1 | tee -a $LOGFILE
  echo " "
done
git clone https://bitbucket.org/jpcgt/flatcam.git 2>&1 | tee -a $LOGFILE
sudo mkdir /usr/local/share/applications/ 2>&1 | tee -a $LOGFILE
sudo mv ./flatcam /usr/local/share/applications
sudo ln -s /usr/local/share/applications/flatcam/flatcam /usr/local/bin/flatcam
echo "" 2>&1 | tee -a $LOGFILE
echo "Einde $appTxt1 build install" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE


cd ~/Downloads
echo "* Installeer pi-apps app store" 2>&1 | tee -a $LOGFILE
wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash 2>&1 | tee -a $LOGFILE



echo "minimale Raspbian desktop installatie afgerond" 2>&1 | tee -a $LOGFILE
