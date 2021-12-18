_hn1=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/$0-`date +%Y-%m-%d_%Hh%Mm`.log
AQUIET=""

mkdir ~/logs
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
ROOT_PASS="rider506"
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

# set de  screensaver uit
sudo sed -i -e 'xserver-command xserver-command=X -s 0 -p 0 -dpms' /etc/lightdm/lightdm.conf
xset s 0
xset -dpms


echo "** installeer X-Apps zoals KVM."
for addonnodes in raspberrypi-ui-mods xinit xserver-xorg xrdp  remmina barrier thonny kodi chromium code tightvncserver audacity rpi-imager piclone guvcview ; do
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
for addonnodes in grafana telegraf ; do
  echo " "
  echo " "
  echo "Installeren TIG Stack: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo /bin/systemctl enable grafana-server
sudo /bin/systemctl start grafana-server
echo "grafana-server is geïnstalleerd"


## https://nwmichl.net/2020/07/14/telegraf-influxdb-grafana-on-raspberrypi-from-scratch/
echo "Setup telegraf database op InfluxDB"  2>&1 | tee -a $LOGFILE
sudo usermod -a -G video telegraf
tg_db=$"create database telegraf; use telegraf;  create user telegrafuser with password 'Telegr@f' with all privileges; grant all privileges on telegraf to telegrafuser; create retention policy '4Weeks' on 'telegraf' duration 4w replication 1 default; exit;"
influx -execute $tg_db   2>&1 | tee -a $LOGFILE

_tg_conf=$('[[outputs.influxdb]] \
   urls = ["http://127.0.0.1:8086"] \
   database = "telegraf" \
   username = "telegrafuser" \
   password = "Telegr@f" \
  ')
echo $_tg_conf >> /etc/telegraf/telegraf.conf
sudo service telegraf restart


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

echo "* Installeer auto update als crontab taak"
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/autoupdate.sh
chmod +x ./autoupdate.sh
sudo mv ./autoupdate.sh /usr/local/bin
mkdir ~/logs
touch ~/logs/cronlog.txt
echo "0 0 * * SAT sh /usr/local/bin/autoupdate.sh 2>/home/pi/logs/cronlog.txt" | sudo tee -a /etc/crontab
sudo service cron restart

echo "* installeren Wireguard VPN"
cd ~/Downloads
sudo apt install wireguard raspberrypi-kernel-headers -y
echo "deb http://deb.debian.org/debian/ unstable main" | sudo tee --append /etc/apt/sources.list.d/unstable.list
sudo apt update -y
sudo apt install dirmngr -y
wget -O - https://ftp-master.debian.org/keys/archive-key-$(lsb_release -sr).asc | sudo apt-key add -
printf 'Package: *\nPin: release a=unstable\nPin-Priority: 150\n' | sudo tee --append /etc/apt/preferences.d/limit-unstable
sudo apt update -y
sudo apt install wireguard -y
sudo systemctl enable wg-quick@wg0


cd ~/Downloads
printstatus "Installeren box86 emulatie ref--> https://pimylifeup.com/raspberry-pi-x86/"
for addonnodes in gcc-arm-linux-gnueabihf libc6:armhf libncurses5:armhf libstdc++6:armhf cmake ; do
  echo " "
  echo " "
  echo "Installeren box86 vereisten: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done
git clone https://github.com/ptitSeb/box86
cd ./box86
mkdir build
cd build
cmake .. -DRPI2=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo  2>&1 | tee -a $LOGFILE
make -j$(nproc)  2>&1 | tee -a $LOGFILE
sudo make install   2>&1 | tee -a $LOGFILE
sudo systemctl restart systemd-binfmt
sudo rm -rf ~/Downloads/box86
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/teamspeak.service
sudo mv ./teamspeak.service /etc/systemd/system
sudo systemctl enable teamspeak.service
printstatus "box86 voorbeeld. Start Teamspeak"
wget https://files.teamspeak-services.com/releases/server/3.13.3/teamspeak3-server_linux_x86-3.13.3.tar.bz2  2>&1 | tee -a $LOGFILE
tar -xvpf teamspeak3-server_linux_x86-3.13.3.tar.bz2  2>&1 | tee -a $LOGFILE
cd ./teamspeak3-server_linux_x86
cd ~/Downloads
sudo mv ./teamspeak3-server_linux_x86 /usr/local/share
sudo touch /usr/local/share/teamspeak3-server_linux_x86/.ts3server_license_accepted
sudo service teamspeak restart
## ./ts3server  2>&1 & | tee -a $LOGFILE

printstatus "Installeren nukkit Minecraft lokale server"
sudo apt install -y default-jdk
mkdir ~/Downloads
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/nukkitminecraft.service
sudo mv ./nukkitminecraft.service /etc/systemd/system
sudo systemctl enable nukkitminecraft.service
cd /usr/local/bin
sudo wget -O nukkit.jar https://go.pimylifeup.com/3xsPQA/nukkit 2>&1 | tee -a $LOGFILE
sudo service nukkitminecraft restart

echo "* Installeren steampowered.com"
## java -jar nukkit.jar &
for addonnodes in libappindicator1 libnm0 libtcmalloc-minimal4 steamlink steam-devices ; do
  echo " "
  echo " "
  echo "Installeren steampowered vereisten: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done
#echo 'gpu_mem=128' | sudo tee -a /boot/config.txt | tee -a $LOGFILE
sudo chmod +rw /dev/uinput
sudo usermod -aG input pi
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/steamlink.service
sudo mv ./steamlink.service /etc/systemd/system
sudo systemctl enable steamlink.service
sudo touch /etc/profile.d/steam.sh
wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb
sudo dpkg -i ./steam.deb
sudo rm -rf ./steam.deb
sudo touch  /etc/profile.d/steam.sh
echo 'export STEAMOS=1' | sudo tee -a /etc/profile.d/steam.sh
echo 'export STEAM_RUNTIME=1' | sudo tee -a /etc/profile.d/steam.sh
sudo service steamlink status

echo "* Installeren muble VoIP"
for addonnodes in mumble-server mumble ; do
  echo " "
  echo " "
  echo "Installeren mumble vereisten: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done
sudo mkdir /var/log/mumble-server
sudo touch /var/log/mumble-server/mumble-server.log
sudo service mumble-server status


cd $_pwd

echo "Virtuahlere draadloos Wifi is geinstalleerd."
echo "* Install extras is afgerond. Je kunt nu herstarten."
