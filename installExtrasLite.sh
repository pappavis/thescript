_hn1=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/installExtras-`date +%Y-%m-%d_%Hh%Mm`.log
AQUIET=""

echo "" 2>&1 | tee -a $LOGFILE
echo "START installExtrasLite.sh $(date)" 2>&1 | tee -a $LOGFILE
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

cd ~/Downloads
echo "" 2>&1 | tee -a $LOGFILE
echo "**Instellen tailscale VPN" 2>&1 | tee -a $LOGFILE
sudo apt install -y apt-transport-https 2>&1 | tee -a $LOGFILE
curl -fsSL https://pkgs.tailscale.com/stable/raspbian/buster.gpg | sudo apt-key add -
curl -fsSL https://pkgs.tailscale.com/stable/raspbian/buster.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt-get update -y 2>&1 | tee -a $LOGFILE
sudo apt-get install tailscale -y 2>&1 | tee -a $LOGFILE
sudo tailscale up 2>&1 | tee -a $LOGFILE
tailscale ip -4


cd ~/Downloads
appTxt1="**BIPES online Micropython blokken omgeving"
echo "" 2>&1 | tee -a $LOGFILE
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
git clone https://github.com/BIPES/BIPES 2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/html/apps
sudo mv  ./BIPES /var/www/html/apps
echo "Einde $appTxt1 build install" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

cd ~/Downloads
appTxt1="**Bitsy fantasy console"
echo "" 2>&1 | tee -a $LOGFILE
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
git clone https://github.com/le-doux/bitsy 2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/html/apps
sudo mkdir /var/www/html/apps/bitsy
cp -r -v ./bitsy/editor /var/www/html/apps/bitsy
echo "Einde $appTxt1 build install" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

echo "EIND installExtrasLite.sh $(date)" 2>&1 | tee -a $LOGFILE