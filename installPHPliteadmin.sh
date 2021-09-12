echo "* Installeer phpliteadmin voor sqlite."
sudo apt install -y apache2 php php-mysql php-sqlite3
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
