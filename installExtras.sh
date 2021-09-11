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
echo "* Start VirtualHerer Raspberry Pi server"
#sudo vhusbdarmpi3 -b

echo "* Installeer phpliteadmin voor sqlite."
mkdir ~/dbs
mkdir ~/Downloads/phpliteadmin
wget https://bitbucket.org/phpliteadmin/public/downloads/phpLiteAdmin_v1-9-8-2.zip
cd ~/Downloads/phpliteadmin 
7z x ~/Downloads/phpLiteAdmin_v1-9-8-2.zip
cp -r -v phpliteadmin.config.sample.php phpliteadmin.config.php 
sudo mkdir /var/www/html/support
sudo mv ~/Downloads/phpliteadmin /var/www/html/support
sudo chown www-data:www-data -R /var/www/html/support/phpliteadmin
sudo apt install -y php-sqlite3 php-pdo-sqlite php-mbstring openssl
echo "PHPliteadmin is geïnstaleerd voor http://$_hn1.local/phpalitedmin"
sudo service apache2 restart

sudo apt-get install -y phpmyadmin
sudo ln -s /usr/share/phpmyadmin /var/www/html
sudo apt install -y raspberrypi-ui-mods
echo "Je moet 'vhusbdarmpi3 -b' toevoegen aan /etc/rc.local. voor de exit 0 "
