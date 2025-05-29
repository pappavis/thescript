LOGFILE=$HOME/logs/installPHPliteadmin-`date +%Y-%m-%d_%Hh%Mm`.log
adminpass="admin"
HOSTNAME=$(hostname)
_pwd=$(pwd)
mkdir ~/logs

echo "PHPliteadmin wordt geïnstalleerd" 2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/html/support/phpliteadmin
cd /var/www/html/support/phpliteadmin
sudo rm -rf ./phpliteadmin-dev*
sudo wget https://www.phpliteadmin.org/phpliteadmin-dev.zip 2>&1 | tee -a $LOGFILE

sudo 7z x phpliteadmin-dev.zip 2>&1 | tee -a $LOGFILE
sudo mv ./phpliteadmin.php ./index.php 2>&1 | tee -a $LOGFILE
sudo mv ./phpliteadmin.config.sample.php ./phpliteadmin.config.php 2>&1 | tee -a $LOGFILE
sudo rm *.zip 2>&1 | tee -a $LOGFILE
sudo mkdir themes 2>&1 | tee -a $LOGFILE
#cd themes
#sudo wget -a http://bitbucket.org/phpliteadmin/public/downloads/phpliteadmin_themes_2016-02-29.zip -a $LOGFILE
#sudo unzip phpliteadmin_themes_2016-02-29.zip 2>&1 | tee -a $LOGFILE
#sudo rm *.zip
sudo sed -i -e 's#\$directory = \x27.\x27;#\$directory = \x27/home/pi/dbs/\x27;#g' /var/www/html/support/phpliteadmin/phpliteadmin.config.php
sudo sed -i -e "s#\$password = \x27admin\x27;#\$password = \x27$adminpass\x27;#g" /var/www/html/support/phpliteadmin/phpliteadmin.config.php
sudo sed -i -e "s#\$subdirectories = false;#\$subdirectories = true;#g" /var/www/html/support/phpliteadmin/phpliteadmin.config.php
sudo rm -rf ./phpliteadmin-dev* 2>&1 | tee -a $LOGFILE

cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/index_apps.php 2>&1 | tee -a $LOGFILE
sudo mv index_apps.php /var/www/html
sudo rm -rf /var/www/html/index.html
sudo rm -rf /var/www/html/index.php

cd $_pwd


echo "PHPliteadmin bereikbaar op http://$HOSTNAME.local/support/phpliteadmin"
