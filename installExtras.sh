_hn1=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/$0-`date +%Y-%m-%d_%Hh%Mm`.log
AQUIET=""

git pull
cd ~/Downloads
echo "Download en installeer virtualhere.com Pi 3 server & client"
curl https://raw.githubusercontent.com/virtualhere/script/main/install_server | sudo sh

cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/index_apps.php
sudo mv index_apps.php /var/www/html
sudo rm -rf /var/www/html/index.html
sudo rm -rf /var/www/html/index.php


#wget https://www.virtualhere.com/sites/default/files/usbserver/vhusbdarmpi3
#wget https://www.virtualhere.com/sites/default/files/usbclient/vhuitarm7
#wget https://virtualhere.com/sites/default/files/usbserver/vhusbdarmpi
#wget https://virtualhere.com/sites/default/files/usbserver/vhusbdx86_64
#chmod +x ./vhusbdarmpi3
#chmod +x ./vhuitarm7
#chmod +x ./vhusbdarmpi
#chmod +x ./vhusbdx86_64
#sudo cp -r -v ./vhusbd* /usr/local/bin
#sudo cp ./vhui* /usr/local/bin
curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python

sudo apt-get install -y phpmyadmin
APP_PASS="rider506"
ROOT_PASS="rider506d"
APP_DB_PASS="rider506"

echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $APP_PASS" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $ROOT_PASS" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $APP_DB_PASS" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo  debconf-set-selections

sudo apt install -y phpmyadmin
sudo ln -s /usr/share/phpmyadmin /var/www/html

cd /var/www/html 
sudo git clone https://github.com/phpsysinfo/phpsysinfo.git
sudo cp /var/www/html/phpsysinfo/phpsysinfo.ini.new /var/www/html/phpsysinfo/phpsysinfo.ini

echo "admin\n"| sudo apt install -y firebird-server
echo "admin\n"| sudo apt install -y postgresql

cd ~/Downloads/
git clone --depth 1 https://code.videolan.org/videolan/x264
cd ~/Downloads/x264
./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl
make -j4
sudo make install


cd ~/Downloads/

sudo apt update -y
echo "** installeer minimale Raspbian desktop."
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

echo "** installeer X-Apps zoals KVM."
for addonnodes in raspberrypi-ui-mods xinit xserver-xorg xrdp  remmina barrier thonny kodi chromium code tightvncserver audacity rpi-imager piclone  ; do
  echo " "
  echo " "
  echo "Installeren ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo adduser xrdp ssl-cert 
systemctl show -p SubState --value xrdp

echo "* Installeer btop proceslijst"
cd ~/Downloads/
sudo rm -rf ./btop*
mkdir ./btop_install
cd ./btop_install
wget https://github.com/aristocratos/btop/releases/download/v1.1.2/btop-1.1.2-armv5l-linux-musleabi.tbz
wget https://github.com/aristocratos/btop/releases/download/v1.1.2/btop-1.1.2-armv7l-linux-musleabihf.tbz
7z x ./btop-1.1.2-armv5l-linux-musleabi.tbz
7z x ./btop-1.1.2-armv5l-linux-musleabi.tar
sudo make

cd $_pwd
echo "* Doen ook --> sudo nano /etc/samba/smb.conf -y"

echo "* Installeer pi-apps app store"
wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash

echo "* Installeer webmin"
cd ~/Downloads
wget -a $LOGFILE http://www.webmin.com/jcameron-key.asc -O - | sudo apt-key add -
echo "deb http://download.webmin.com/download/repository sarge contrib" | sudo tee /etc/apt/sources.list.d/webmin.list > /dev/null
sudo apt-get $AQUIET -y update 2>&1 | tee -a $LOGFILE
sudo apt-get $AQUIET -y install webmin 2>&1 | tee -a $LOGFILE
sudo sed -i -e 's#ssl=1#ssl=0#g' /etc/webmin/miniserv.conf

echo "* Installeer amiberry"
cd ~/Downloads
sudo apt install -y libsdl2-ttf-dev libsdl2-image-dev
wget https://github.com/midwan/amiberry/releases/download/v4.1.6/amiberry-v4.1.6-rpi3-sdl2-32bit-rpios.zip
7z x ./amiberry-v4.1.6-rpi3-sdl2-32bit-rpios.zip
rm ./amiberry-v4.1.6-rpi3-sdl2-32bit-rpios.zip
sudo mv ./amiberry-rpi3-sdl2-32bit /usr/local/games
sudo ln -s /usr/local/games/amiberry-rpi3-sdl2-32bit/amiberry /usr/local/bin/amiberry

echo "Installeren Grafana"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get update -y
sudo apt-get install -y grafana
sudo systemctl unmask grafana-server.service
sudo systemctl start grafana-server
sudo systemctl enable grafana-server.service


echo "Installeren chronograf"
sudo apt-get install -y chronograf 
sudo systemctl enable chronograf 2>&1 | tee -a $LOGFILE
sudo systemctl start chronograf 2>&1 | tee -a $LOGFILE

echo "Installeren influxdb"
wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/os-release
echo "deb https://repos.influxdata.com/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt update -y
sudo apt install -y influxdb
sudo systemctl unmask influxdb.service
sudo systemctl start influxdb
sudo systemctl enable influxdb.service

cd ~/Downloads/
wget https://dl.influxdata.com/telegraf/releases/telegraf-1.20.3_linux_armhf.tar.gz
tar xf telegraf-1.20.3_linux_armhf.tar.gz


echo "Installeren RPI-Clone"
cd ~/Downloads
sudo git clone https://github.com/billw2/rpi-clone.git
cd rpi-clone
sudo cp rpi-clone /usr/local/sbin
cd ~/Downloads
sudo rm -r rpi-clone

echo "Installeren log2ram"
cd ~/Downloads
git clone https://github.com/azlux/log2ram.git 2>&1 | tee -a $LOGFILE
cd log2ram
chmod +x install.sh
sudo ./install.sh 2>&1 | tee -a $LOGFILE
cd ~/Downloads

cd /var/www/html
sudo wget -a $LOGFILE $AQUIET https://www.scargill.net/iot/reset.css -O /var/www/html/reset.css

cd ~/Downloads
echo "Motorola 68000 emulatie in Python, voor de lol."
git clone https://github.com/Chris-Johnston/Easier68k
cd Easier68k
pip install -r requirements.txt
ehco "je kunt nu: python ./cli.py"

cd ~/Downloads
echo "Installeren Grafana" 
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt update -y
sudo apt-get install -y grafana
sudo /bin/systemctl enable grafana-server
sudo /bin/systemctl start grafana-server
echo "grafana-server is geïnstalleerd"

cd ~/Downloads
echo "Motorola 68000 emulatie in C, voor de lol."
git clone https://github.com/kstenerud/Musashi
cd Musashi
make

echo "* Installeren Docker"
cd ~/Downloads
curl -fsSL https://get.docker.com  -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

echo "* Installeren rpi-clone"
cd ~/Downloads
sudo apt install -y git
wget https://github.com/billw2/rpi-clone/archive/master.zip
unzip master.zip && mv rpi-clone-master rpi-clone
sudo cp rpi-clone/rpi-clone* /usr/local/sbin
rm -rf rpi-clone master.zip


cd $_pwd

echo "Virtuahlere draadloos Wifi is geinstalleerd."
echo "* Install extras is afgerond. Je kunt nu herstarten."
