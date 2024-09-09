#!/bin/bash
_hn1=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/installExtras-`date +%Y-%m-%d_%Hh%Mm`.log
AQUIET=""

bash ./installExtrasLite.sh

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

cd /var/www/html
sudo wget -a $LOGFILE $AQUIET https://www.scargill.net/iot/reset.css -O /var/www/html/reset.css 2>&1 | tee -a $LOGFILE

cd ~/Downloads
echo "Motorola 68000 emulatie in Python, voor de lol." 2>&1 | tee -a $LOGFILE
git clone https://github.com/Chris-Johnston/Easier68k 2>&1 | tee -a $LOGFILE
cd ./Easier68k
pip install -r requirements.txt 2>&1 | tee -a $LOGFILE
ehco "je kunt nu: python ./cli.py"


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
sudo rm -rf ./teamspeak3-server_linux_x86-3.13.3.tar.bz2

printstatus "Installeren nukkit Minecraft lokale server" 2>&1 | tee -a $LOGFILE
sudo apt install -y default-jdk 2>&1 | tee -a $LOGFILE
mkdir ~/Downloads
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/services/nukkitminecraft.service 2>&1 | tee -a $LOGFILE
sudo mv ./nukkitminecraft.service /etc/systemd/system
sudo systemctl enable nukkitminecraft.service
cd /usr/local/bin
sudo wget -O nukkit.jar https://go.pimylifeup.com/3xsPQA/nukkit 2>&1 | tee -a $LOGFILE
sudo service nukkitminecraft restart


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


echo "" 2>&1 | tee -a $LOGFILE
echo "Instellen Retropie" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git 2>&1 | tee -a $LOGFILE
cd ./RetroPie-Setup
echo "\n\n\I\n" | sudo ./retropie_setup.sh 2>&1 | tee -a $LOGFILE
echo "Einde Retropie install" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

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
lsusb 2>&1 | tee -a $LOGFILE
sudo usbip bind --busid=YYYY:ZZZZ
sudo usbipd -D

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
appTxt1="wordpress"
echo "" 2>&1 | tee -a $LOGFILE
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/html/sites
wget https://nl.wordpress.org/latest-nl_NL.zip 2>&1 | tee -a $LOGFILE
7z x ./latest-nl_NL.zip
sudo mkdir /var/www/html/sites
sudo mkdir /var/www/html/sites/wordpress_test
sudo mv ./wordpress/* /var/www/html/sites/wordpress_test
sudo mv /var/www/html/sites/wordpress /var/www/html/sites/wordpress_test
sudo chown www-data:www-data -R /var/www/html/sites
rm -rf ./wordpress*
rm -rf ./latest-nl_NL.zip
echo "Einde $appTxt1 build install" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE



echo "* Install extras is afgerond. Je kunt nu herstarten." 2>&1 | tee -a $LOGFILE

cd $_pwd


cd ~/Downloads
appTxt1="Freeboard online data analyse omgeving"
echo "" 2>&1 | tee -a $LOGFILE
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
sudo npm install -g grunt 2>&1 | tee -a $LOGFILE
git clone https://github.com/BIPES/freeboard 2>&1 | tee -a $LOGFILE
cd ./freeboard
npm install 2>&1 | tee -a $LOGFILE
grunt 2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/html/apps
cd ~/Downloads
sudo mv  ./freeboard /var/www/html/apps
echo "Einde $appTxt1 build install" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE


echo "install micropython Webrepl website" 2>&1 | tee -a $LOGFILE
git clone https://github.com/micropython/webrepl 2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/html/apps
sudo cp -r -v ./webrepl /var/www/html/apps 2>&1 | tee -a $LOGFILE
sudo cp /var/www/html/apps/micropython_webrepl/webrepl.html /var/www/html/apps/micropython_webrepl/index.php 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE


echo "EINDE installExtras.sh $(date)" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

