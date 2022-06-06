#!/bin/bash
_hn1=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/installExtras-`date +%Y-%m-%d_%Hh%Mm`.log
AQUIET=""

mkdir ~/logs
git pull
cd ~/Downloads
echo "Download en installeer virtualhere.com Pi 3 server & client" 2>&1 | tee -a $LOGFILE
curl https://raw.githubusercontent.com/virtualhere/script/main/install_server | sudo sh 2>&1 | tee -a $LOGFILE
echo "Virtualhere draadloos Wifi is geinstalleerd." 2>&1 | tee -a $LOGFILE

cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/index_apps.php 2>&1 | tee -a $LOGFILE
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
curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python3


#sudo apt-get install -y phpmyadmin 2>&1 | tee -a $LOGFILE
#sudo ln -s /usr/share/phpmyadmin /var/www/html

sudo mkdir /var/www/html/support
cd /var/www/html 
sudo git clone https://github.com/phpsysinfo/phpsysinfo.git 2>&1 | tee -a $LOGFILE
sudo cp /var/www/html/phpsysinfo/phpsysinfo.ini.new /var/www/html/phpsysinfo/phpsysinfo.ini 2>&1 | tee -a $LOGFILE


cd ~/Downloads/
git clone --depth 1 https://code.videolan.org/videolan/x264 2>&1 | tee -a $LOGFILE
cd ~/Downloads/x264
./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl 2>&1 | tee -a $LOGFILE
make -j$(nproc)
sudo make install 2>&1 | tee -a $LOGFILE
rm -rf ~/Downloads/x264

cd $_pwd
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
for addonnodes in libsdl2-2.0-0 libsdl2-ttf-2.0-0 libsdl2-image-2.0-0 flac mpg123 libmpeg2-4 libsdl2-dev libsdl2-ttf-dev libsdl2-image-dev libflac-dev libmpg123-dev libpng-dev libmpeg2-4-dev libraspberrypi-dev libsdl2-ttf-dev libsdl2-image-dev ; do
  echo " "
  echo " "
  echo "Installeren amiberry vereisten: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

if [[ $(arch) -eq 'armv6l' ]] 
 then
	echo "Amiberry op PiZero wordt gemaakt" 2>&1 | tee -a $LOGFILE
	git clone https://github.com/midwan/amiberry 2>&1 | tee -a $LOGFILE
	cd amiberry
	make PLATFORM=rpi1 2>&1 | tee -a $LOGFILE
	sudo make install
  else
	echo "Amiberry op Pi3, Pi4 gedownload" 2>&1 | tee -a $LOGFILE
	wget https://github.com/midwan/amiberry/releases/download/v5.1/amiberry-v5.1-rpi3-sdl2-32bit-rpios.zip 2>&1 | tee -a $LOGFILE
	7z x ./amiberry-v5.1-rpi3-sdl2-32bit-rpios.zip 2>&1 | tee -a $LOGFILE
	rm ./amiberry-v5.1-rpi3-sdl2-32bit-rpios.zip	
	sudo rm -rf /usr/local/games/amiberry-rpi3-sdl2-32bit
	sudo mv ./amiberry-rpi3-sdl2-32bit/ /usr/local/games/
	sudo ln -s /usr/local/games/amiberry-rpi3-sdl2-32bit/amiberry  /usr/local/bin/amiberry
	sudo rm -rf ./amiberry-rpi3-sdl2-32bit
 fi
rm -rf ./amiberry
echo "Amiberry install afgerond" 2>&1 | tee -a $LOGFILE


cd ~/Downloads/
echo "* Installeren chronograf" 2>&1 | tee -a $LOGFILE
wget wget  https://dl.influxdata.com/chronograf/releases/chronograf-1.9.4_linux_armhf.tar.gz  2>&1 | tee -a $LOGFILE
tar xf ./chronograf-1.9.4_linux_armhf.tar.gz
sudo cp -R ./chronograf-1.9.4-1/* /  2>&1 | tee -a $LOGFILE
wget https://raw.githubusercontent.com/pappavis/thescript/master/services/chronograf.service 2>&1 | tee -a $LOGFILE
sudo mv ./chronograf.service /etc/systemd/system 2>&1 | tee -a $LOGFILE
sudo systemctl enable chronograf
sudo systemctl start chronograf
sudo systemctl status chronograf 2>&1 | tee -a $LOGFILE
sudo docker pull chronograf:1.9  2>&1 | tee -a $LOGFILE
rm -rf ./chronograf-1.9.4*


cd ~/Downloads/
echo "* Installeer telegraf" 2>&1 | tee -a $LOGFILE
wget wget https://dl.influxdata.com/telegraf/releases/telegraf-1.22.4_linux_armhf.tar.gz  2>&1 | tee -a $LOGFILE
tar xf ./telegraf-1.22.4_linux_armhf.tar.gz
sudo cp -R -v ./telegraf-1.22.4/* /  2>&1 | tee -a $LOGFILE
wget https://raw.githubusercontent.com/pappavis/thescript/master/services/telegraf.service 2>&1 | tee -a $LOGFILE
sudo mv ./telegraf.service /etc/systemd/system 2>&1 | tee -a $LOGFILE
sudo systemctl enable telegraf
sudo systemctl start telegraf
sudo systemctl status telegraf 2>&1 | tee -a $LOGFILE
rm -rf ./telegraf-1.22.4*

_tg_conf=$('[[outputs.influxdb]] \
   urls = ["http://127.0.0.1:8086"] \
   database = "telegraf" \
   username = "telegrafuser" \
   password = "Telegr@f" \
  ')
echo $_tg_conf | sudo tee -a /etc/telegraf/telegraf.conf 2>&1 | tee -a $LOGFILE
sudo service telegraf restart
sudo service telegraf status 2>&1 | tee -a $LOGFILE


cd ~/Downloads/
echo "* Installeer influxdb" 2>&1 | tee -a $LOGFILE
echo "deb [signed-by=/usr/share/keyrings/influxdb-archive-keyring.gpg] https://repos.influxdata.com/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt update -y 2>&1 | tee -a $LOGFILE
sudo apt install influxdb -y 2>&1 | tee -a $LOGFILE
sudo systemctl enable influxdb
sudo systemctl start influxdb
sudo service influxdb status 2>&1 | tee -a $LOGFILE
## https://nwmichl.net/2020/07/14/telegraf-influxdb-grafana-on-raspberrypi-from-scratch/
sudo usermod -a -G video telegraf

echo "Setup telegraf database op InfluxDB"  2>&1 | tee -a $LOGFILE
tg_db=$"create database telegraf; use telegraf;  create user telegrafuser with password 'Telegr@f' with all privileges; grant all privileges on telegraf to telegrafuser; create retention policy '4Weeks' on 'telegraf' duration 4w replication 1 default; exit;"
influx -execute $tg_db   2>&1 | tee -a $LOGFILE
echo "create database telegraf;" | influx 2>&1 | tee -a $LOGFILE
echo "use telegraf" | influx 2>&1 | tee -a $LOGFILE
echo "create user telegrafuser with password 'Telegr@f' with all privileges; " | influx 2>&1 | tee -a $LOGFILE
echo "grant all privileges on telegraf to telegrafuser; " | influx
echo "create retention policy '4Weeks' on 'telegraf' duration 4w replication 1 default; " | influx 2>&1 | tee -a $LOGFILE

cd ~/Downloads/
echo "* Installeer grafana" 2>&1 | tee -a $LOGFILE
sudo wget https://dl.grafana.com/oss/release/grafana-rpi_6.6.1_armhf.deb 2>&1 | tee -a $LOGFILE
sudo dpkg -i ./grafana-rpi_6.6.1_armhf.deb 2>&1 | tee -a $LOGFILE
sudo systemctl enable grafana-server 2>&1 | tee -a $LOGFILE
sudo systemctl status grafana-server 2>&1 | tee -a $LOGFILE
echo "grafana-server is geïnstalleerd op http://$(hostname).local:3000" 2>&1 | tee -a $LOGFILE
sudo usermod -a -G video telegraf


echo " * Installeren RPI-Clone" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
sudo git clone https://github.com/billw2/rpi-clone.git 2>&1 | tee -a $LOGFILE
cd rpi-clone
sudo cp rpi-clone /usr/local/sbin
cd ~/Downloads
sudo rm -r rpi-clone


echo " * Installeren log2ram" 2>&1 | tee -a $LOGFILE
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

echo "Installeren CommanderPi"  2>&1 | tee -a $LOGFILE
cd ~/Downloads
git clone https://github.com/jack477/CommanderPi 2>&1 | tee -a $LOGFILE
cd ./CommanderPi
echo "Y\n" | bash ./install.sh 2>&1 | tee -a $LOGFILE
rm -rf ./CommanderPi


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
wget https://raw.githubusercontent.com/pappavis/thescript/master/services/teamspeak.service
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

cd $_pwd

echo "* Installeren mumble VoIP" 2>&1 | tee -a $LOGFILE
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

cd $_pwd

echo "Instellen dagelijks NFS server mounts" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/installNFSserver.sh 2>&1 | tee -a $LOGFILE
chmod +x ./installNFSserver.sh
sudo mv ./installNFSserver.sh /etc/cron.daily/mountNFSservers.sh

echo "Instellen wekelijks systeem bijgewerkt" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
touch ./refresh.sh
echo "#/bin/bash"  2>&1 | sudo tee -a ./refresh.sh
echo "LOGFILE=/home/pi/logs/refreshBijwerken.log"  2>\&1 | sudo tee -a ./refresh.sh
echo "echo '' | tee -a \$LOGFILE"  2>&1 | sudo tee -a $LOGFILE 
echo "echo 'refresh bijwerken gestart' | tee -a \$LOGFILE &"  2>&1 | sudo tee -a $LOGFILE
echo "mkdir /home/pi/Downloads | tee -a \$LOGFILE"  2>&1 | sudo tee -a ./refresh.sh
echo "cd /home/pi/Downloads"  2>&1  | sudo tee -a ./refresh.sh
echo "rm -rf ./autoupdate.sh"  2>&1 | sudo tee -a ./refresh.sh
echo "wget https://raw.githubusercontent.com/pappavis/thescript/master/autoupdate.sh  2>&1 | tee -a \$LOGFILE"  | sudo tee -a ./refresh.sh
echo "chmod +x ./autoupdate.sh | tee -a \$LOGFILE"  2>&1 | sudo tee -a ./refresh.sh
echo "sudo mv ./autoupdate.sh /etc/cron.weekly | tee -a \$LOGFILE"  2>&1 | sudo tee -a ./refresh.sh
echo "sudo service cron restart | tee -a \$LOGFILE"  2>&1 | sudo tee -a ./refresh.sh
chmod +x ./refresh.sh 
sudo mv ./refresh.sh /etc/cron.daily/refresh.sh
sudo service cron restart

cd ~/Downloads
touch ./pythonBijwerken.sh
echo "#/bin/bash"  2>&1 | sudo tee -a ./pythonBijwerken.sh
echo "LOGFILE=/home/pi/logs/pythonBijwerken.log"  2>&1 | sudo tee -a ./pythonBijwerken.sh
echo "echo '' | tee -a \$LOGFILE &"  2>&1 | sudo tee -a ./pythonBijwerken.sh
echo "echo 'Python bijwerken gestart' | tee -a \$LOGFILE &"  2>&1 | sudo tee -a ./pythonBijwerken.sh
echo "source /home/pi/.bashrc | tee -a \$LOGFILE"  2>&1 | sudo tee -a ./pythonBijwerken.sh
echo "mkdir /home/pi/Downloads | tee -a \$LOGFILE"  2>&1 | sudo tee -a ./pythonBijwerken.sh
echo "git clone https://github.com/pappavis/thescript | tee -a \$LOGFILE" 2>&1 | sudo tee -a ./pythonBijwerken.sh
echo "cd /home/pi/Downloads/thescript | tee -a \$LOGFILE"  2>&1 | sudo tee -a ./pythonBijwerken.sh
echo "git pull | tee -a \$LOGFILE"  2>&1 | sudo tee -a ./pythonBijwerken.sh
echo "bash /home/pi/Downloads/thescript/installPythonLibs.sh | tee -a \$LOGFILE &"  2>&1 | sudo tee -a ./pythonBijwerken.sh
echo "bash /home/pi/Downloads/thescript/installPythonCircuitpython.sh  | tee -a \$LOGFILE &"  2>&1 | sudo tee -a ./pythonBijwerken.sh
echo "echo '' | tee -a \$LOGFILE &"  2>&1 | sudo tee -a ./pythonBijwerken.sh
chmod +x ./pythonBijwerken.sh
sudo mv ./pythonBijwerken.sh /etc/cron.monthly/pythonBijwerken.sh
sudo service cron restart

#echo "* Installeer auto update als crontab taak" 2>&1 | tee -a $LOGFILE
#touch ~/logs/cronlog.txt
#echo "0 0 * * SAT sh /usr/local/bin/autoupdate.sh 2>/home/pi/logs/cronlog.txt" | sudo tee -a /etc/crontab
#sudo service cron restart

cd ~/Downloads
echo "Instellen Raspberry PI RP2040 emulatie in Javascript en CircuitPython" 2>&1 | tee -a $LOGFILE
git clone https://github.com/wokwi/rp2040js 2>&1 | tee -a $LOGFILE
cd ./rp2040js
wget https://micropython.org/resources/firmware/rp2-pico-20210902-v1.17.uf2 2>&1 | tee -a $LOGFILE
wget https://downloads.circuitpython.org/bin/raspberry_pi_pico/nl/adafruit-circuitpython-raspberry_pi_pico-nl-7.1.0.uf2
npm install 2>&1 | tee -a $LOGFILE
cd ~/Downloads
rm -rf ./rp2040micropython.service
echo "[Unit]" | tee -a ./rp2040micropython.service
echo "Description=Raspberry Pi Pico RP2040 emulatie" | tee -a ./rp2040micropython.service
echo "After=network-online.target" | tee -a ./rp2040micropython.service
echo "Wants=network-online.target" | tee -a ./rp2040micropython.service
echo "" | tee -a ./rp2040micropython.service
echo "[Service]" | tee -a ./rp2040micropython.service
echo "Type=simple" | tee -a ./rp2040micropython.service
echo "Environment='LC_ALL=NL.UTF-8'" | tee -a ./rp2040micropython.service
echo "Environment='LANG=NL.UTF-8'" | tee -a ./rp2040micropython.service
echo "WorkingDirectory=/var/local/share/rp2040js" | tee -a ./rp2040micropython.service
echo "User=pi" | tee -a ./rp2040micropython.service
echo "ExecStart=npm run start:micropython" | tee -a ./rp2040micropython.service
echo "Restart=on-failure" | tee -a ./rp2040micropython.service | tee -a ./rp2040micropython.service
echo "RestartSec=5" | tee -a ./rp2040micropython.service | tee -a ./rp2040micropython.service
echo "" | tee -a ./rp2040micropython.service
echo "[Install]" | tee -a ./rp2040micropython.service
echo "WantedBy=multi-user.target" | tee -a ./rp2040micropython.service
echo "" | tee -a ./rp2040micropython.service
sudo mv ./rp2040js /usr/local/share
sudo mv ./rp2040micropython.service /etc/systemd/system
sudo sed -i -e "/# Print/s/#/eval \$(cd \/usr\/local\/share\/rp2040js \&\& npm run start:micropython ) \& \n \#/" /etc/rc.local

sudo systemctl enable rp2040micropython.service
sudo service rp2040micropython restart
sudo service rp2040micropython status

cd $_pwd
echo "Instellen nutsfunctie printstatus()" 2>&1 | tee -a $LOGFILE
sudo cp -v $_pwd/installNutsfuncties.sh /usr/local/bin 2>&1 | tee -a $LOGFILE
sudo chmod +x /usr/local/bin/installNutsfuncties.sh
sudo sed -i -e '/exit 0/s/exit/##exit/' /etc/bash.bashrc
cat ./installNutsfuncties.sh  2>&1 | sudo  tee -a  /etc/bash.bashrc
echo "#exit 0"  2>&1 | sudo tee -a  /etc/bash.bashrc



echo "** installeer QEMU virtual machine" 2>&1 | tee -a $LOGFILE
# https://www.christitus.com/vm-setup-in-linux
# It should be above 0
virtualizationActive=$(egrep -c '(vmx|svm)' /proc/cpuinfo)  
for addonnodes in qemu qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager ; do
  echo " "
  echo " "
  echo "Installeren qemu: ${addonnodes}" 2>&1 | tee -a $LOGFILE
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done
#Verify that Libvirtd service is started
sudo systemctl status libvirtd.service 2>&1 | tee -a $LOGFILE
sudo virsh net-start default 2>&1 | tee -a $LOGFILE
echo "check qmeu netwerk status" 2>&1 | tee -a $LOGFILE
sudo virsh net-list --all 2>&1 | tee -a $LOGFILE
for addonnodes in libvirt libvirt-qemu ; do
  echo " "
  echo " "
  echo "Installeren ${addonnodes}" 2>&1 | tee -a $LOGFILE
  echo " "
  sudo adduser pi ${addonnodes} 2>&1 | tee -a $LOGFILE
done
sudo service libvirtd status 2>&1 | tee -a $LOGFILE
sudo virsh net-start default 2>&1 | tee -a $LOGFILE
sudo virsh net-autostart default 2>&1 | tee -a $LOGFILE
sudo virsh net-list --all 2>&1 | tee -a $LOGFILE
echo "qemu install afgerond." 2>&1 | tee -a $LOGFILE

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

echo "" 2>&1 | tee -a $LOGFILE
echo "Instellen Retropie" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git 2>&1 | tee -a $LOGFILE
cd ./RetroPie-Setup
echo "\n\n\I\n" | sudo ./retropie_setup.sh 2>&1 | tee -a $LOGFILE
echo "Einde Retropie install" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

echo "" 2>&1 | tee -a $LOGFILE
echo "Instellen Mega65.org emulatie" 2>&1 | tee -a $LOGFILE
for addonnodes in git build-essential libsdl2-dev libgtk-3-dev libreadline-dev libncurses5-dev libncursesw5-dev ; do
  echo " "
  echo " "
  echo "Installeren Mega65.org vereisten: ${addonnodes}" 2>&1 | tee -a $LOGFILE
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done
cd ~/Downloads
git clone https://github.com/lgblgblgb/xemu.git 2>&1 | tee -a $LOGFILE
cd ./xemu
make | tee -a $LOGFILE
sudo cp -r -v ./build/bin /usr/local/share/xemu 2>&1 | tee -a $LOGFILE
sudo cp -r -v ./rom/* /usr/local/share/xemu 2>&1 | tee -a $LOGFILE
sudo cp -r -v ./rom/* /home/pi/.local/share/xemu-lgb/c65/default-files/ 2>&1 | tee -a $LOGFILE
sudo ln -s /usr/local/share/xemu/xc65.native /usr/local/bin/x65 2>&1 | tee -a $LOGFILE
cd ~/Downloads
wget https://github.com/MEGA65/open-roms/raw/master/bin/mega65.rom 2>&1 | tee -a $LOGFILE
wget http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/c65/911001.bin 2>&1 | tee -a $LOGFILE
sudo mv ./mega65.rom /home/pi/.local/share/xemu-lgb/c65/default-files/c65-system.rom 2>&1 | tee -a $LOGFILE
sudo mv ./911001.bin /home/pi/.local/share/xemu-lgb/c65/default-files/mega65.bin 2>&1 | tee -a $LOGFILE

rm -rf ~/Downloads/xemu 2>&1 | tee -a $LOGFILE


cd ~/Downloads
echo "" 2>&1 | tee -a $LOGFILE
echo "Instellen sqliteBrowser" 2>&1 | tee -a $LOGFILE
for addonnodes in build-essential git-core cmake libsqlite3-dev qt5-default qttools5-dev-tools libsqlcipher-dev qtbase5-dev libqt5scintilla2-dev libqcustomplot-dev qttools5-dev ; do
  echo " "
  echo " "
  echo "Installeren sqliteBrowser.org vereisten: ${addonnodes}" 2>&1 | tee -a $LOGFILE
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done
git clone https://github.com/sqlitebrowser/sqlitebrowser 2>&1 | tee -a $LOGFILE
cd sqlitebrowser
mkdir build
cd build
cmake -Dsqlcipher=1 -Wno-dev .. 2>&1 | tee -a $LOGFILE
make 2>&1 | tee -a $LOGFILE
sudo make install 2>&1 | tee -a $LOGFILE
cd ~/Downloads
rm -rf ./sqlitebrowser
echo "" 2>&1 | tee -a $LOGFILE


cd ~/Downloads
echo "" 2>&1 | tee -a $LOGFILE
echo "Instellen tailscale VPN" 2>&1 | tee -a $LOGFILE
sudo apt install -y apt-transport-https 2>&1 | tee -a $LOGFILE
curl -fsSL https://pkgs.tailscale.com/stable/raspbian/buster.gpg | sudo apt-key add -
curl -fsSL https://pkgs.tailscale.com/stable/raspbian/buster.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt-get update -y 2>&1 | tee -a $LOGFILE
sudo apt-get install tailscale -y 2>&1 | tee -a $LOGFILE
sudo tailscale up 2>&1 | tee -a $LOGFILE
tailscale ip -4


cd ~/Downloads
echo "" 2>&1 | tee -a $LOGFILE
echo "Instellen Resilio Sync als Dropbox alternatief" 2>&1 | tee -a $LOGFILE
echo "resilio sync --> https://www.thedigitalpictureframe.com/how-to-create-a-dropbox-like-file-synchronization-setup-on-the-raspberry-pi-with-resilio/" 2>&1 | tee -a $LOGFILE
echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list 2>&1 | tee -a $LOGFILE
wget -qO - https://linux-packages.resilio.com/resilio-sync/key.asc | sudo apt-key add - 2>&1 | tee -a $LOGFILE
sudo dpkg --add-architecture armel && sudo apt update -y 2>&1 | tee -a $LOGFILE
echo "deb [arch=armel] http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list
sudo apt update -y && sudo apt install resilio-sync -y 2>&1 | tee -a $LOGFILE
sudo systemctl enable resilio-sync 2>&1 | tee -a $LOGFILE
sudo service resilio-sync status 2>&1 | tee -a $LOGFILE
echo "Open nu de website http://$(hostname):8888/gui" 2>&1 | tee -a $LOGFILE

cd ~/Downloads
echo "" 2>&1 | tee -a $LOGFILE
echo "Instellen USB over IP   ref--> https://usbip.sourceforge.net" 2>&1 | tee -a $LOGFILE
sudo apt install -y usbip 2>&1 | tee -a $LOGFILE
sudo modprobe usbip-core 2>&1 | tee -a $LOGFILE
sudo modprobe usbip-host 2>&1 | tee -a $LOGFILE
sudo usbip -D 2>&1 | tee -a $LOGFILE
usbip list -l 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE


cd ~/Downloads
echo "Instellen docker" 2>&1 | tee -a $LOGFILE
curl -fsSL get.docker.com -o get-docker.sh 2>&1 | tee -a $LOGFILE
sudo sh get-docker.sh 2>&1 | tee -a $LOGFILE
sudo usermod -aG docker pi 2>&1 | tee -a $LOGFILE
sudo curl https://download.docker.com/linux/raspbian/gpg 2>&1 | tee -a $LOGFILE
sudo service docker restart 2>&1 | tee -a $LOGFILE
sudo service docker status 2>&1 | tee -a $LOGFILE
sudo docker info 2>&1 | tee -a $LOGFILE
sudo docker run hello-world 2>&1 | tee -a $LOGFILE
sudo docker pull grafana/grafana 2>&1 | tee -a $LOGFILE
sudo docker run -d --name=grafana -p 3000:3000 grafana/grafana 2>&1 | tee -a $LOGFILE

cd ~/Downloads
echo "Instellen OpenVPN" 2>&1 | tee -a $LOGFILE
sudo apt-get install -y openvpn openssl 2>&1 | tee -a $LOGFILE
sudo cp -r -v /usr/share/easy-rsa /etc/openvpn/easy-rsa 2>&1 | tee -a $LOGFILE
sudo sed -i -e "/export EASY_RSA=`pwd`/s/`pwd`/'/etc/openvpn/easy-rsa'/" /etc/openvpn/easy-rsa/vars
echo "export EASY_RSA=/etc/openvpn/easy-rsa" | tee -a  /etc/openvpn/easy-rsa/vars 2>&1 | tee -a $LOGFILE

cd ~/Downloads
echo "" 2>&1 | tee -a $LOGFILE
echo "Instellen OpenVPN ref--> https://youtu.be/gxpX_mubz2A?t=1077  en  https://raspberrytips.nl/pivpn-de-eenvoudige-manier-om-openvpn-te-installeren/" 2>&1 | tee -a $LOGFILE
#curl -L http://install.pivpn.io  | sudo bash 2>&1 | tee -a $LOGFILE
##wget https://git.io/vpn -O openvpn-install.sh && echo "1\n" 2>&1 | tee -a $LOGFILE
##sudo bash openvpn-install.sh 2>&1 | tee -a $LOGFILE

cd ~/Downloads
echo "" 2>&1 | tee -a $LOGFILE
echo "Instellen OpenMediaVault  ref--> https://www.wundertech.net/turn-a-raspberry-pi-into-a-nas-openmediavault-tutorial/" 2>&1 | tee -a $LOGFILE
curl -sSL https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/ma


cd ~/Downloads
echo "" 2>&1 | tee -a $LOGFILE
echo "Installeren Bootstrap.js bibliotheek" 2>&1 | tee -a $LOGFILE
wget https://github.com/twbs/bootstrap/releases/download/v5.1.3/bootstrap-5.1.3-dist.zip 2>&1 | tee -a $LOGFILE
7z x bootstrap-5.1.3-dist.zip 2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/html/support 2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/html/inc 2>&1 | tee -a $LOGFILE
sudo mv -v bootstrap-5.1.3-dist /var/www/html/inc/ 2>&1 | tee -a $LOGFILE
sudo mv -v /var/www/html/inc/bootstrap-5.1.3-dist /var/www/html/inc/bootstrap 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE


cd ~/Downloads
sudo rm -rf ./x16-emulator
echo "" 2>&1 | tee -a $LOGFILE
echo "Commander X-16 emulatie installeren" 2>&1 | tee -a $LOGFILE
wget https://github.com/commanderx16/x16-emulator.git 2>&1 | tee -a $LOGFILE
cd ./x16-emulator
make  2>&1 | tee -a $LOGFILE
sudo cp -r -v ./x16emu /usr/local/bin 2>&1 | tee -a $LOGFILE
sudo cp -r -v ./webassembly/ /var/www/html/ 2>&1 | tee -a $LOGFILE
sudo mv /var/www/html/webassembly /var/www/html/commander16
sudo mkdir /var/www/html/commander16/webassembly
cd /var/www/html/commander16
sudo mv -v ./* ./webassembly 2>&1 | tee -a $LOGFILE
sudo wget https://sebastianvog.github.io/x16-emulator/x16emu.html 2>&1 | tee -a $LOGFILE
sudo wget https://sebastianvog.github.io/x16-emulator/x16emu.data 2>&1 | tee -a $LOGFILE
sudo wget https://sebastianvog.github.io/x16-emulator/x16emu.js 2>&1 | tee -a $LOGFILE
sudo wget https://sebastianvog.github.io/x16-emulator/x16emu.wasm 2>&1 | tee -a $LOGFILE
sudo chown www-data:www-data -R /var/www/html/commander16/
cd ~/Downloads
sudo rm -rf ./x16-emulator
echo "" 2>&1 | tee -a $LOGFILE
echo "Commander X-16 emulatie installeren afgerond." 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

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
echo "Einde $appTxt1 build install" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE


cd ~/Downloads
appTxt1="FlatCam PCB router"
echo "" 2>&1 | tee -a $LOGFILE
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
git clone https://bitbucket.org/jpcgt/flatcam.git 2>&1 | tee -a $LOGFILE
sudo mkdir /usr/local/share/applications/ 2>&1 | tee -a $LOGFILE
sudo mv -f ./flatcam /usr/local/applications
echo "" 2>&1 | tee -a $LOGFILE
echo "Einde $appTxt1 build install" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

echo "* Install extras is afgerond. Je kunt nu herstarten." 2>&1 | tee -a $LOGFILE

cd $_pwd
