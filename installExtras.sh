_hn1=$(hostname)
cd ~/Downloads
echo "Download en installeer virtualhere.com Pi 3 server & client"
curl https://raw.githubusercontent.com/virtualhere/script/main/install_server | sudo sh

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

echo "* Start VirtualHerer Raspberry Pi server"
#sudo vhusbdarmpi3 -b

sudo apt-get install -y phpmyadmin
APP_PASS="rider506"
ROOT_PASS="rider506d"
APP_DB_PASS="rider506"

echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $APP_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $ROOT_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $APP_DB_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections

sudo apt install -y phpmyadmin
sudo ln -s /usr/share/phpmyadmin /var/www/html

cd /var/www/html 
sudo git clone https://github.com/phpsysinfo/phpsysinfo.git
sudo cp /var/www/html/phpsysinfo/phpsysinfo.ini.new /var/www/html/phpsysinfo/phpsysinfo.ini

cd ~/Downloads/
git clone --depth 1 https://code.videolan.org/videolan/x264
cd ~/Downloads/x264
./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl
make -j4
sudo make install


cd ~/Downloads/

sudo apt update -y
echo "** installeer minimale Raspbian desktop."
sudo apt install -y raspberrypi-ui-mods xinit xserver-xorg xrdp  

echo "** installeer barrier KVM."
sudo apt install -y remmina barrier

sudo adduser xrdp ssl-cert 
systemctl show -p SubState --value xrdp

echo "* Installeer btop proceslijst"
cd ~/Downloads/
wget https://github.com/aristocratos/btop/releases/download/v1.0.13/btop-1.0.13-linux-armhf.tbz
7z x btop-1.0.13-linux-armhf.tbz
mkdir ./btop_install
cd ./btop_install
7z x ../btop-1.0.13-linux-armhf.tar
sudo make install
cd ~/Downloads/thescript
sudo nano /etc/samba/smb.conf -y

echo "Virtuahlere draadloos Wifi is geinstalleerd."
echo "* Install extras is afgerond."
