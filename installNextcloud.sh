#!/bin/bash
LOGFILE=~/logs/installNextcloud.log
# ref --> https://www.linuxbabe.com/ubuntu/install-nextcloud-ubuntu-20-04-apache-lamp-stack
echo ""  2>&1 | tee -a $LOGFILE
echo "Start installNextcloud.sh"  2>&1 | tee -a $LOGFILE
echo ""  2>&1 | tee -a $LOGFILE

for addonnodes in imagemagick php-imagick libapache2-mod-php7.4 php-common php-mysql php-fpm php-gd php-json php-curl php-zip php-xml php-mbstring php--bz2 php-intl php-bcmath php-gmp certbot python3-certbot-apache redis-server php-redis ; do
  echo " "
  echo " "
  echo "Installeren Nextcloud vereisten: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

pip install certbot-apache 2>&1 | tee -a $LOGFILE

mkdir ~/Downloads
cd ~/Downloads
sudo mkdir /var/www/html/support

rm -rf ./nextcloud*  2>&1 | tee -a $LOGFILE
wget https://download.nextcloud.com/server/releases/nextcloud-21.0.1.zip   2>&1 | tee -a $LOGFILE
7z x ./nextcloud-21.0.1.zip  2>&1 | tee -a $LOGFILE
sudo mv ./nextcloud /var/www/html/support  2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/nextcloud/nextcloud-data
wget https://raw.githubusercontent.com/pappavis/thescript/master/owncloud_config.php  2>&1 | tee -a $LOGFILE
rm -rf ./owncloud_config.php 
sudo mv ./owncloud_config.php /var/www/html/support/nextcloud/config/config.php
sudo chown www-data:www-data -R /var/www/html/support/nextcloud  2>&1 | tee -a $LOGFILE
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT 2>&1 | tee -a $LOGFILE
sudo certbot --apache --agree-tos --redirect --staple-ocsp --email you@example.com -d nextcloud.example.com 2>&1 | tee -a $LOGFILE
sudo -u www-data php /var/www/support/nextcloud/occ user:resetpassword nextcloud_username 2>&1 | tee -a $LOGFILE
sudo -u www-data php /var/www/support/nextcloud/occ 2>&1 | tee -a $LOGFILE

sudo mysql -u root -p echo "create database nextcloud\n" 2>&1 | tee -a $LOGFILE
sudo sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php/7.4/apache2/php.ini 2>&1 | tee -a $LOGFILE
sudo sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 999M/g' /etc/php/7.4/apache2/php.ini 2>&1 | tee -a $LOGFILE
sudo service apache2 restart

echo "Einde installNextcloud.sh"  2>&1 | tee -a $LOGFILE
echo ""  2>&1 | tee -a $LOGFILE
