_hn1=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/installOwncloud-`date +%Y-%m-%d_%Hh%Mm`.log
mkdir ~/logs
printf "\nStart instellen van NFS server op \n" $_ip1 ".local\n"

echo ""   2>&1 | tee -a $LOGFILE
echo ""   2>&1 | tee -a $LOGFILE
echo "* Instaleer Owncloud"   2>&1 | tee -a $LOGFILE
cd ~/Downloads
sudo apt update -y

for addonnodes in apache2 php php-mysql php-intl php-zip php-GD php-gd php-curl ; do
	echo ""   2>&1 | tee -a $LOGFILE
	echo ""   2>&1 | tee -a $LOGFILE
	echo "Installeren Owncloud vereisten:  \"${addonnodes}\""
  	sudo apt install -y ${addonnodes}   2>&1 | tee -a $LOGFILE
done

echo ""   2>&1 | tee -a $LOGFILE

# https://robertopozzi.medium.com/have-fun-with-your-raspberry-pi-secure-your-application-with-self-signed-certificates-c8ef455a492f
#sudo mkdir -p /etc/ssl/mycerts   2>&1 | tee -a $LOGFILE
#sudo openssl req -new -x509 -days 365 -nodes -out /etc/ssl/mycerts/apache.pem -keyout /etc/ssl/mycerts/apache.key   2>&1 | tee -a $LOGFILE
#sudo chmod 600 /etc/ssl/mycerts/apache*

# https://superuser.com/questions/835542/how-can-i-access-owncloud-files-by-the-owncloud-server
echo " mounting dafvs naar /mnt/davfs2/$(hostname)"   2>&1 | tee -a $LOGFILE
echo "\n" | sudo apt install -y davfs2   2>&1 | tee -a $LOGFILE
sudo mkdir /mnt/davfs2
sudo mkdir /mnt/davfs2/$(hostname)  2>&1 | tee -a $LOGFILE &
# https://ajclarkson.co.uk/blog/auto-mount-webdav-raspberry-pi/
sudo chmod u+s /usr/sbin/mount.davfs  2>&1 | tee -a $LOGFILE  2>&1 | tee -a $LOGFILE &
sudo usermod -a -G davfs2 pi  2>&1 | tee -a $LOGFILE &
mkdir ~/.davfs2  2>&1 | tee -a $LOGFILE &
touch ~/.dav2fs/secrets  2>&1 | tee -a $LOGFILE &
chmod 0600 ~/.dav2fs/secrets  2>&1 | tee -a $LOGFILE &
openssl x509 -in server.crt -out ~/Downloads/server.pem -outform PEM
mv ~/Downloads/server.pem ~/.dav2fs/secrets 
echo "servercert	server.pem" | tee -a ~/.davfs2/davfs2.conf

mkdir ~/.dav2fs
echo "https://$(hostname).local/support/owncloud/remote.php/webdav admin  admin" | tee -a ~/.dav2fs/secret  2>&1 | tee -a $LOGFILE &

sudo mount -t davfs  $(hostname).local/support/owncloud/remote.php/webdav /mnt/davfs2/$(hostname)  2>&1 | tee -a $LOGFILE &
echo " dafvs mouting afgerond."   2>&1 | tee -a $LOGFILE

sudo phpenmod  intl  2>&1 | tee -a $LOGFILE
cd ~/Downloads
wget https://download.owncloud.com/server/stable/owncloud-complete-latest.zip  2>&1 | tee -a $LOGFILE
7z x ~/Downloads/owncloud-complete-latest.zip  2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/html/support  2>&1 | tee -a $LOGFILE
sudo mv ~/Downloads/owncloud /var/www/html/support  2>&1 | tee -a $LOGFILE
wget https://raw.githubusercontent.com/pappavis/thescript/master/owncloud_config.php  2>&1 | tee -a $LOGFILE
sudo mv ~/Downloads/thescript/owncloud_config.php /var/www/html/support/owncloud/config/config.php
sudo chown -R www-data:www-data /var/www/html/support/owncloud  2>&1 | tee -a $LOGFILE
sudo service apache2 restart  2>&1 | tee -a $LOGFILE
#sudo cp -v /var/www/html/support/owncloud/config/config.apps.sample.php /var/www/html/support/owncloud/config/config.php  2>&1 | tee -a $LOGFILE

echo " mounting dafvs naar /mnt/davfs2/$(hostname)"   2>&1 | tee -a $LOGFILE
sudo chmod u+s /usr/sbin/mount.davfs 2>&1 | tee -a $LOGFILE
echo "Owncloud beschikbaar op http://$(hostname).local/support/owncloud"  2>&1 | tee -a $LOGFILE
sudo rm -rf ~/Downloads/*owncloud-complete*  2>&1 | tee -a $LOGFILE
echo "EINDE installOwncloud.sh"   2>&1 | tee -a $LOGFILE
echo ""   2>&1 | tee -a $LOGFILE
echo ""   2>&1 | tee -a $LOGFILE
cd $_pwd
