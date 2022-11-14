_hn1=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/installExtras-`date +%Y-%m-%d_%Hh%Mm`.log
AQUIET=""

echo "" 2>&1 | tee -a $LOGFILE
echo "START installExtras.sh $(date)" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

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

curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python3
echo "export TERM=xterm-256color"  2>&1 | sudo tee -a /home/dataplicity/.bashrc

#sudo apt-get install -y phpmyadmin 2>&1 | tee -a $LOGFILE
#sudo ln -s /usr/share/phpmyadmin /var/www/html

sudo mkdir /var/www/html/support
cd /var/www/html 
sudo git clone https://github.com/phpsysinfo/phpsysinfo.git 2>&1 | tee -a $LOGFILE
sudo cp /var/www/html/phpsysinfo/phpsysinfo.ini.new /var/www/html/phpsysinfo/phpsysinfo.ini 2>&1 | tee -a $LOGFILE

echo "* Installeer webmin" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
wget -a $LOGFILE http://www.webmin.com/jcameron-key.asc -O - | sudo apt-key add - 2>&1 | tee -a $LOGFILE
echo "deb http://download.webmin.com/download/repository sarge contrib" | sudo tee /etc/apt/sources.list.d/webmin.list > /dev/null
sudo apt-get $AQUIET -y update 2>&1 | tee -a $LOGFILE
sudo apt-get $AQUIET -y install webmin 2>&1 | tee -a $LOGFILE
sudo sed -i -e 's#ssl=1#ssl=0#g' /etc/webmin/miniserv.conf

#wget https://www.virtualhere.com/sites/default/files/usbserver/vhusbdarmpi3
wget https://www.virtualhere.com/sites/default/files/usbclient/vhuitarm7
#wget https://virtualhere.com/sites/default/files/usbserver/vhusbdx86_64
#chmod +x ./vhusbdarmpi3
chmod +x ./vhuitarm7
#chmod +x ./vhusbdarmpi
#chmod +x ./vhusbdx86_64
sudo cp -r -v ./vhusbd* /usr/local/bin
#sudo cp ./vhui* /usr/local/bin
curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python3
echo "export TERM=xterm-256color"  2>&1 | sudo tee -a /home/dataplicity/.bashrc
