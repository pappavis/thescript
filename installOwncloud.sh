_hn1=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/installOwncloud-`date +%Y-%m-%d_%Hh%Mm`.log
mkdir ~/logs
printf "\nStart instellen van NFS server op \n" $_ip1 ".local\n"

echo "* Instaleer Owncloud"   2>&1 | tee -a $LOGFILE
cd ~/Downloads
sudo apt update -y

for addonnodes in apache2 php php-mysql php-intl ; do
	echo "Installeren Owncloud vereisten:  \"${addonnodes}\""
  sudo apt install -y ${addonnodes}   2>&1 | tee -a $LOGFILE
done

# https://superuser.com/questions/835542/how-can-i-access-owncloud-files-by-the-owncloud-server
echo " mounting dafvs naar /mnt/davfs2/$(hostname)"   2>&1 | tee -a $LOGFILE
echo "\n" | sudo apt install -y davfs2   2>&1 | tee -a $LOGFILE
sudo mkdir /mnt/davfs2
sudo mkdir /mnt/davfs2/$(hostname)
mount -t auto $(hostname)/owncloud/remote.php/webdav /mnt/davfs2/$(hostname)
echo " dafvs mouting afgerond."   2>&1 | tee -a $LOGFILE

sudo phpenmod  intl  2>&1 | tee -a $LOGFILE
wget https://download.owncloud.org/community/owncloud-latest.zip  2>&1 | tee -a $LOGFILE
7z x ~/Downloads/owncloud-latest.zip  2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/html/support  2>&1 | tee -a $LOGFILE
sudo mv ~/Downloads/owncloud /var/www/html/support  2>&1 | tee -a $LOGFILE
sudo chown -R www-data:www-data /var/www/html/support/owncloud  2>&1 | tee -a $LOGFILE
sudo service apache2 restart  2>&1 | tee -a $LOGFILE
echo "Owncloud beschikbaar op http://$(hostname).local/support/owncloud"  2>&1 | tee -a $LOGFILE
sudo rm -rf ~/Downloads/*owncloud-complete*  2>&1 | tee -a $LOGFILE
cd $_pwd
