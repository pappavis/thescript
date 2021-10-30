_hn1=$(hostname)
echo "* Instaleer Owncloud"
cd ~/Downloads
sudo apt update -y
sudo apt install -y apache2 php php-mysql php-intl
sudo phpenmod  intl
wget https://download.owncloud.org/community/owncloud-complete-20210721.zip
7z x ~/Downloads/owncloud-complete-20210721.zip
sudo mkdir /var/www/html/support
sudo mv ~/Downloads/owncloud /var/www/html/support
sudo chown -R www-data:www-data /var/www/html/support/owncloud
sudo service apache2 restart
echo "Owncloud beschikbaar op http://$_hn1.local/support/owncloud"
