#!/bin/bash
_hn1=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/installExtras-`date +%Y-%m-%d_%Hh%Mm`.log
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
#wget https://virtualhere.com/sites/default/files/usbserver/vhusbdx86_64
#chmod +x ./vhusbdarmpi3
#chmod +x ./vhuitarm7
#chmod +x ./vhusbdarmpi
#chmod +x ./vhusbdx86_64
#sudo cp -r -v ./vhusbd* /usr/local/bin
#sudo cp ./vhui* /usr/local/bin
curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python

APP_PASS="rider506"
ROOT_PASS="rider506"
APP_DB_PASS="rider506"

# https://stackoverflow.com/questions/30741573/debconf-selections-for-phpmyadmin-unattended-installation-with-no-webserver-inst
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/internal/skip-preseed boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean false"
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $APP_PASS" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $ROOT_PASS" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $APP_DB_PASS" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo  debconf-set-selections

sudo apt-get install -y phpmyadmin 2>&1 | tee -a $LOGFILE

sudo ln -s /usr/share/phpmyadmin /var/www/html

cd /var/www/html 
sudo git clone https://github.com/phpsysinfo/phpsysinfo.git 2>&1 | tee -a $LOGFILE
sudo cp /var/www/html/phpsysinfo/phpsysinfo.ini.new /var/www/html/phpsysinfo/phpsysinfo.ini 2>&1 | tee -a $LOGFILE


for addonnodes in  firebird-server postgresql  ; do
  echo " "
  echo " "
  echo "Installeren sql database server: ${addonnodes}"
  echo " "
  echo "admin\n" | sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done


cd ~/Downloads/
git clone --depth 1 https://code.videolan.org/videolan/x264 2>&1 | tee -a $LOGFILE
cd ~/Downloads/x264
./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl 2>&1 | tee -a $LOGFILE
make -j$(nproc)
sudo make install 2>&1 | tee -a $LOGFILE
rm -rf ~/Downloads/x264

cd ~/Downloads/
wget -qO - https://packages.grafana.com/gpg.key |  sudo gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/example.gpg --import -
curl -sL https://packages.grafana.com/gpg.key | sudo apt-key add -
curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
echo "deb https://repos.influxdata.com/debian dists buster stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
sudo apt update -y 2>&1 | tee -a $LOGFILE

echo "** installeer minimale Raspbian desktop." 2>&1 | tee -a $LOGFILE
for addonnodes in raspberrypi-ui-mods xinit xserver-xorg xrdp   ; do
  echo " "
  echo " "
  echo "Installeren: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo systemctl enable influxdb grafana-server telegraf
sudo systemctl start influxdb grafana-server telegraf
sudo systemctl status influxdb grafana-server telegraf 2>&1 | tee -a $LOGFILE

sudo mkdir /home/pi/.local
sudo mkdir /home/pi/.local/share
sudo mkdir /home/pi/.local/share/lxsession
sudo mkdir /home/pi/.local/share/lxterminal

# set de  screensaver uit
sudo sed -i -e 'xserver-command xserver-command=X -s 0 -p 0 -dpms' /etc/lightdm/lightdm.conf
xset s 0
xset -dpms


echo "** installeer X-Apps zoals KVM." 2>&1 | tee -a $LOGFILE
for addonnodes in raspberrypi-ui-mods xinit xserver-xorg xrdp  remmina barrier thonny kodi chromium code tightvncserver audacity rpi-imager piclone guvcview ; do
  echo " "
  echo " "
  echo "Installeren ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo adduser xrdp ssl-cert  2>&1 | tee -a $LOGFILE
systemctl show -p SubState --value xrdp 2>&1 | tee -a $LOGFILE

cd $_pwd
echo "* Doen ook --> sudo nano /etc/samba/smb.conf -y" 2>&1 | tee -a $LOGFILE

echo "* Installeer pi-apps app store" 2>&1 | tee -a $LOGFILE
wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash 2>&1 | tee -a $LOGFILE

echo "* Installeer webmin" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
wget -a $LOGFILE http://www.webmin.com/jcameron-key.asc -O - | sudo apt-key add - 2>&1 | tee -a $LOGFILE
echo "deb http://download.webmin.com/download/repository sarge contrib" | sudo tee /etc/apt/sources.list.d/webmin.list > /dev/null
sudo apt-get $AQUIET -y update 2>&1 | tee -a $LOGFILE
sudo apt-get $AQUIET -y install webmin 2>&1 | tee -a $LOGFILE
sudo sed -i -e 's#ssl=1#ssl=0#g' /etc/webmin/miniserv.conf

echo "* Installeer amiberry" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
sudo apt install -y libsdl2-ttf-dev libsdl2-image-dev
wget https://github.com/midwan/amiberry/releases/download/v4.1.6/amiberry-v4.1.6-rpi3-sdl2-32bit-rpios.zip 2>&1 | tee -a $LOGFILE
7z x ./amiberry-v4.1.6-rpi3-sdl2-32bit-rpios.zip
rm ./amiberry-v4.1.6-rpi3-sdl2-32bit-rpios.zip
sudo mv ./amiberry-rpi3-sdl2-32bit /usr/local/games
sudo ln -s /usr/local/games/amiberry-rpi3-sdl2-32bit/amiberry /usr/local/bin/amiberry

echo "Installeren Grafana" 2>&1 | tee -a $LOGFILE
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list 2>&1 | tee -a $LOGFILE
sudo apt-get update -y
sudo apt-get install -y grafana 2>&1 | tee -a $LOGFILE
sudo systemctl unmask grafana-server.service
sudo systemctl start grafana-server
sudo systemctl enable grafana-server.service


echo "Installeren chronograf" 2>&1 | tee -a $LOGFILE
sudo apt-get install -y chronograf  2>&1 | tee -a $LOGFILE
sudo systemctl enable chronograf 2>&1 | tee -a $LOGFILE
sudo systemctl start chronograf 2>&1 | tee -a $LOGFILE

echo "Installeren influxdb" 2>&1 | tee -a $LOGFILE
wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/os-release
echo "deb https://repos.influxdata.com/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt update -y
sudo apt install -y influxdb 2>&1 | tee -a $LOGFILE
sudo systemctl unmask influxdb.service
sudo systemctl start influxdb
sudo systemctl enable influxdb.service


echo "Installeren RPI-Clone" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
sudo git clone https://github.com/billw2/rpi-clone.git 2>&1 | tee -a $LOGFILE
cd rpi-clone
sudo cp rpi-clone /usr/local/sbin
cd ~/Downloads
sudo rm -r rpi-clone

echo "Installeren log2ram" 2>&1 | tee -a $LOGFILE
echo "deb http://packages.azlux.fr/debian/ bullseye main" | sudo tee /etc/apt/sources.list.d/azlux.list
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
sudo apt update -y 2>&1 | tee -a $LOGFILE
sudo apt install log2ram -y 2>&1 | tee -a $LOGFILE

cd /var/www/html
sudo wget -a $LOGFILE $AQUIET https://www.scargill.net/iot/reset.css -O /var/www/html/reset.css 2>&1 | tee -a $LOGFILE

cd ~/Downloads
echo "Motorola 68000 emulatie in Python, voor de lol." 2>&1 | tee -a $LOGFILE
git clone https://github.com/Chris-Johnston/Easier68k 2>&1 | tee -a $LOGFILE
cd ./Easier68k
pip install -r requirements.txt 2>&1 | tee -a $LOGFILE
ehco "je kunt nu: python ./cli.py"

cd ~/Downloads
echo "Installeren Grafana en telegraf"  2>&1 | tee -a $LOGFILE
curl -sL https://packages.grafana.com/gpg.key | sudo apt-key add -
curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
echo "deb https://repos.influxdata.com/debian dists buster stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
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
echo "grafana-server is geïnstalleerd" 2>&1 | tee -a $LOGFILE
sudo usermod -a -G video telegraf


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
echo $_tg_conf >> /etc/telegraf/telegraf.conf 2>&1 | tee -a $LOGFILE
sudo service telegraf restart
sudo service telegraf status 2>&1 | tee -a $LOGFILE

cd ~/Downloads
echo "Motorola 68000 emulatie in C, voor de lol." 2>&1 | tee -a $LOGFILE
git clone https://github.com/kstenerud/Musashi 2>&1 | tee -a $LOGFILE
cd Musashi
make 2>&1 | tee -a $LOGFILE

echo "* Installeren Docker" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
curl -fsSL https://get.docker.com  -o get-docker.sh 2>&1 | tee -a $LOGFILE
sudo sh get-docker.sh 2>&1 | tee -a $LOGFILE
sudo usermod -aG docker $USER

echo "* Installeren rpi-clone" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
sudo apt install -y git 2>&1 | tee -a $LOGFILE
wget https://github.com/billw2/rpi-clone/archive/master.zip 2>&1 | tee -a $LOGFILE
unzip master.zip && mv rpi-clone-master rpi-clone 2>&1 | tee -a $LOGFILE
sudo cp rpi-clone/rpi-clone* /usr/local/sbin
rm -rf rpi-clone master.zip

echo "* installeren Wireguard VPN" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
sudo apt install wireguard raspberrypi-kernel-headers -y 2>&1 | tee -a $LOGFILE
echo "deb http://deb.debian.org/debian/ unstable main" | sudo tee --append /etc/apt/sources.list.d/unstable.list
sudo apt update -y
sudo apt install dirmngr -y
wget -O - https://ftp-master.debian.org/keys/archive-key-$(lsb_release -sr).asc | sudo apt-key add -
printf 'Package: *\nPin: release a=unstable\nPin-Priority: 150\n' | sudo tee --append /etc/apt/preferences.d/limit-unstable
sudo apt update -y
sudo apt install wireguard -y 2>&1 | tee -a $LOGFILE
sudo systemctl enable wg-quick@wg0


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

printstatus "Installeren nukkit Minecraft lokale server" 2>&1 | tee -a $LOGFILE
sudo apt install -y default-jdk 2>&1 | tee -a $LOGFILE
mkdir ~/Downloads
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/nukkitminecraft.service 2>&1 | tee -a $LOGFILE
sudo mv ./nukkitminecraft.service /etc/systemd/system
sudo systemctl enable nukkitminecraft.service
cd /usr/local/bin
sudo wget -O nukkit.jar https://go.pimylifeup.com/3xsPQA/nukkit 2>&1 | tee -a $LOGFILE
sudo service nukkitminecraft restart

echo "* Installeren steampowered.com" 2>&1 | tee -a $LOGFILE
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
sudo usermod -aG input pi 2>&1 | tee -a $LOGFILE
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/steamlink.service 2>&1 | tee -a $LOGFILE
sudo mv ./steamlink.service /etc/systemd/system
sudo systemctl enable steamlink.service
sudo touch /etc/profile.d/steam.sh
wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb 2>&1 | tee -a $LOGFILE
sudo dpkg -i ./steam.deb 2>&1 | tee -a $LOGFILE
sudo rm -rf ./steam.deb
sudo touch  /etc/profile.d/steam.sh
echo 'export STEAMOS=1' | sudo tee -a /etc/profile.d/steam.sh 2>&1 | tee -a $LOGFILE
echo 'export STEAM_RUNTIME=1' | sudo tee -a /etc/profile.d/steam.sh
sudo service steamlink status 2>&1 | tee -a $LOGFILE

echo "* Installeren muble VoIP" 2>&1 | tee -a $LOGFILE
for addonnodes in mumble-server mumble ; do
  echo " "
  echo " "
  echo "Installeren mumble vereisten: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done
sudo mkdir /var/log/mumble-server
sudo touch /var/log/mumble-server/mumble-server.log
sudo service mumble-server status 2>&1 | tee -a $LOGFILE

echo "Instellen wekelijks systeem bijgewerkt" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/autoupdate.sh  2>&1 | tee -a $LOGFILE
chmod +x ./autoupdate.sh
sudo mv ./autoupdate.sh /etc/cron.weekly
sudo service cron restart

#echo "* Installeer auto update als crontab taak" 2>&1 | tee -a $LOGFILE
#touch ~/logs/cronlog.txt
#echo "0 0 * * SAT sh /usr/local/bin/autoupdate.sh 2>/home/pi/logs/cronlog.txt" | sudo tee -a /etc/crontab
#sudo service cron restart

cd $_pwd

echo "Virtualhere draadloos Wifi is geinstalleerd." 2>&1 | tee -a $LOGFILE
echo "* Install extras is afgerond. Je kunt nu herstarten." 2>&1 | tee -a $LOGFILE
