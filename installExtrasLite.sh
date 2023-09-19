_hn1=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/installExtrasLite-`date +%Y-%m-%d_%Hh%Mm`.log
AQUIET=""

echo "" 2>&1 | tee -a $LOGFILE
echo "START installExtrasLite.sh $(date)" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

mkdir ~/logs
git pull
cd /home/pi/Downloads/
echo "Download en installeer virtualhere.com Pi 3 server & client" 2>&1 | tee -a $LOGFILE
curl https://raw.githubusercontent.com/virtualhere/script/main/install_server | sudo sh 2>&1 | tee -a $LOGFILE
echo "Virtualhere draadloos Wifi is geinstalleerd." 2>&1 | tee -a $LOGFILE

cd /home/pi/Downloads/
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
cd /home/pi/Downloads/
wget -a $LOGFILE http://www.webmin.com/jcameron-key.asc -O - | sudo apt-key add - 2>&1 | tee -a $LOGFILE
echo "deb http://download.webmin.com/download/repository sarge contrib" | sudo tee /etc/apt/sources.list.d/webmin.list > /dev/null
sudo apt-get $AQUIET -y update 2>&1 | tee -a $LOGFILE
sudo apt-get $AQUIET -y install webmin 2>&1 | tee -a $LOGFILE
sudo sed -i -e 's#ssl=1#ssl=0#g' /etc/webmin/miniserv.conf

echo "Instellen virtualehere.com USB via WiFi" 2>&1 | tee -a $LOGFILE
curl https://raw.githubusercontent.com/virtualhere/script/main/install_server | sudo sh

curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python3
echo "export TERM=xterm-256color"  2>&1 | sudo tee -a /home/dataplicity/.bashrc

cd /home/pi/Downloads/
echo "Instellen dagelijks NFS server mounts" 2>&1 | tee -a $LOGFILE
wget https://raw.githubusercontent.com/pappavis/thescript/master/installNFSserver.sh 2>&1 | tee -a $LOGFILE
chmod +x ./installNFSserver.sh
sudo mv ./installNFSserver.sh /etc/cron.daily/mountNFSservers.sh

cd /home/pi/Downloads/
echo "Instellen wekelijks systeem bijgewerkt" 2>&1 | tee -a $LOGFILE
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

cd /home/pi/Downloads/
touch /home/pi/Downloads/thescript/pythonBijwerken.sh
echo "#/bin/bash"  2>&1 | sudo tee -a /home/pi/Downloads/thescript/pythonBijwerken.sh
echo "LOGFILE=/home/pi/logs/pythonBijwerken.log"  2>&1 | sudo tee -a /home/pi/Downloads/thescript/pythonBijwerken.sh
echo "echo '' | tee -a \$LOGFILE &"  2>&1 | sudo tee -a /home/pi/Downloads/thescript/pythonBijwerken.sh
echo "echo 'Python bijwerken gestart' | tee -a \$LOGFILE &"  2>&1 | sudo tee -a /home/pi/Downloads/thescript/pythonBijwerken.sh
echo "source /home/pi/.bashrc | tee -a \$LOGFILE"  2>&1 | sudo tee -a /home/pi/Downloads/thescript/pythonBijwerken.sh
echo "mkdir /home/pi/Downloads | tee -a \$LOGFILE"  2>&1 | sudo tee -a /home/pi/Downloads/thescript/pythonBijwerken.sh
echo "git clone https://github.com/pappavis/thescript | tee -a \$LOGFILE" 2>&1 | sudo tee -a /home/pi/Downloads/thescript/pythonBijwerken.sh
echo "cd /home/pi/Downloads/thescript | tee -a \$LOGFILE"  2>&1 | sudo tee -a /home/pi/Downloads/thescript/pythonBijwerken.sh
echo "git pull | tee -a \$LOGFILE"  2>&1 | sudo tee -a /home/pi/Downloads/thescript/pythonBijwerken.sh
echo "bash /home/pi/Downloads/thescript/installPythonLibs.sh | tee -a \$LOGFILE &"  2>&1 | sudo tee -a /home/pi/Downloads/thescript/pythonBijwerken.sh
echo "bash /home/pi/Downloads/thescript/installPythonCircuitpython.sh  | tee -a \$LOGFILE &"  2>&1 | sudo tee -a /home/pi/Downloads/thescript/pythonBijwerken.sh
echo "echo '' | tee -a \$LOGFILE &"  2>&1 | sudo tee -a /home/pi/Downloads/thescript/pythonBijwerken.sh
chmod +x /home/pi/Downloads/thescript/pythonBijwerken.sh
sudo mv /home/pi/Downloads/thescript/pythonBijwerken.sh /etc/cron.monthly/pythonBijwerken.sh
sudo service cron restart

cd /home/pi/Downloads/
echo "" 2>&1 | tee -a $LOGFILE
echo "**Instellen tailscale VPN" 2>&1 | tee -a $LOGFILE
sudo apt install -y apt-transport-https 2>&1 | tee -a $LOGFILE
curl -fsSL https://pkgs.tailscale.com/stable/raspbian/buster.gpg | sudo apt-key add -
curl -fsSL https://pkgs.tailscale.com/stable/raspbian/buster.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt-get update -y 2>&1 | tee -a $LOGFILE
sudo apt-get install tailscale -y 2>&1 | tee -a $LOGFILE
sudo tailscale up 2>&1 | tee -a $LOGFILE
tailscale ip -4


cd /home/pi/Downloads/
appTxt1="**BIPES online Micropython blokken omgeving"
echo "" 2>&1 | tee -a $LOGFILE
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
git clone https://github.com/BIPES/BIPES 2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/html/apps
sudo mv  ./BIPES /var/www/html/apps
echo "Einde $appTxt1 build install" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

cd /home/pi/Downloads/
appTxt1="**Bitsy fantasy console"
echo "" 2>&1 | tee -a $LOGFILE
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
git clone https://github.com/le-doux/bitsy 2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/html/apps 2>&1 | tee -a $LOGFILE
sudo mv -v ./bitsy/editor /var/www/html/apps/bitsy 2>&1 | tee -a $LOGFILE
echo "Einde $appTxt1 build install" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

cd /home/pi/Downloads/
appTxt1="**quadplay fantasy console"
echo "" 2>&1 | tee -a $LOGFILE
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
mkdir ~/Downloads/quadplay
wget https://github.com/morgan3d/quadplay/archive/main.zip 2>&1 | tee -a $LOGFILE
7z x ./main.zip 2>&1 | tee -a $LOGFILE

cd /home/pi/Downloads/
appTxt1="**WiringPi bibliotheek"
echo "" 2>&1 | tee -a $LOGFILE
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
sudo apt-get purge wiringpi -y  2>&1 | tee -a $LOGFILE
hash -r
git clone https://github.com/WiringPi/WiringPi.git 2>&1 | tee -a $LOGFILE
cd ./WiringPi
git pull origin 2>&1 | tee -a $LOGFILE
./build 2>&1 | tee -a $LOGFILE
gpio -v 2>&1 | tee -a $LOGFILE
gpio -g mode 18 output 2>&1 | tee -a $LOGFILE

cd /home/pi/Downloads/thescript
bash ./installPHPliteadmin.sh 2>&1 | tee -a $LOGFILE

appTxt1="**https://retroshare.cc/"
echo "" 2>&1 | tee -a $LOGFILE
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
export DEBIAN_VERSION="9.0"
wget -qO - http://download.opensuse.org/repositories/network:retroshare/Raspbian_10/Release.key
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/network:/retroshare/Raspbian_10/ /' > /etc/apt/sources.list.d/retroshare.list"
sudo apt-get -y update
sudo apt-get install -y retroshare-gui

# Create own script that always reports that the Pi is not throttled --- https://community.octoprint.org/t/throttled-system/16422/20
echo "" 2>&1 | tee -a $LOGFILE
appTxt1="**halways reports that the Pi is not throttled "
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
sudo mv /usr/bin/vcgencmd /usr/bin/vcgencmd-dist
sudo touch /usr/bin/vcgencmd
sudo chmod 755 /usr/bin/vcgencmd
echo "#!/bin/bash" 2>&1 | sudo tee /usr/bin/vcgencmd
echo "throttled=0x0" 2>&1 | sudo tee -a /usr/bin/vcgencmd
# restore the original script:
 #sudo rm /usr/bin/vcgencmd
 #sudo mv /usr/bin/vcgencmd-dist /usr/bin/vcgencmd

echo "" 2>&1 | tee -a $LOGFILE
appTxt1="**https://github.com/xtekky/gpt4free/"
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
sudo mkdir /usr/local/bin/apps 2>&1 | tee -a $LOGFILE
for addonnodes in websocket-client requests tls-client pypasser names colorama curl_cffi streamlit==1.21.0 selenium  ; do
  echo "" 2>&1 | tee -a $LOGFILE
  echo "" 2>&1 | tee -a $LOGFILE
  echo "installeren van  ${addonnodes}" 2>&1 | tee -a $LOGFILE
  echo "" 2>&1 | tee -a $LOGFILE
  pip install --upgrade  ${addonnodes}  2>&1 | tee -a $LOGFILE
done
cd /usr/local/apps
sudo git clone https://github.com/xtekky/gpt4free 2>&1 | tee -a $LOGFILE
echo "nohup /home/pi/venv/venv/bin/python /usr/local/apps/gpt4free/gui/streamlit_app.py &"  | sudo tee -a /etc/bash.bashrc 2>&1 | tee -a $LOGFILE &
echo "" 2>&1 | tee -a $LOGFILE

echo "" 2>&1 | tee -a $LOGFILE
appTxt1="**Zoom MS-50G gitaar pedal util -- zoom-ms-utility "
echo "Installeren: $appTxt1" 2>&1 | tee -a $LOGFILE
cd /var/www/html/apps/
sudo git clone https://github.com/g200kg/zoom-ms-utility 2>&1 | tee -a $LOGFILE

cd /usr/local/bin/apps
sudo git clone https://github.com/mriale/PyDPainter 2>&1 | tee -a $LOGFILE

cd /home/pi/Downloads/thescript

echo "EIND installExtrasLite.sh $(date)" 2>&1 | tee -a $LOGFILE
