LOGFILE=$HOME/logs/installPartDB-`date +%Y-%m-%d_%Hh%Mm`.log
_hn1=$(hostname)
_pwd=$(pwd)
mkdir $HOME/logs

echo " "
echo "SETUP: part-db in /var/www/html/support" 2>&1 | tee -a $LOGFILE
echo " "
sudo apt install -y apache2 php php-mysql php-sqlite3 2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/html/support/
sudo mkdir /var/www/html/support/partdb
cd ~/Downloads
wget -O part-db.tar.gz https://github.com/jbtronics/Part-DB/archive/master.tar.gz
sudo tar -xzf part-db.tar.gz -C /var/www/html/support/partdb
sudo mv /var/www/html/support/partdb/Part-DB-master/* /var/www/html/support/partdb
#sudo chown www-root:www-root /var/www/html/support/part-db -R
wget https://github.com/jbtronics/Part-DB/blob/gh-pages/vendor.zip?raw=true
7z x 'vendor.zip?raw=true'
sudo mv ./vendor  /var/www/html/support/partdb
cd  /var/www/html/support/partdb
sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" 2>&1 | tee -a $LOGFILE
rem sudo php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php
sudo php -r "unlink('composer-setup.php');" 2>&1 | tee -a $LOGFILE
sudo chown -R www-data:www-data /var/www/html/support/partdb
mkdir ~/tmp
cd ~/tmp
wget https://raw.githubusercontent.com/pappavis/Part-DB/master/db/partdb.sql 2>&1 | tee -a $LOGFILE
wget https://raw.githubusercontent.com/pappavis/Part-DB/master/db/create_userPartDb.sql 2>&1 | tee -a $LOGFILE
sudo locale-gen en_US.utf8 2>&1 | tee -a $LOGFILE
echo "Upload partdb.sql naar mySQL" 2>&1 | tee -a $LOGFILE
sudo mysql -u root -p < ~/tmp/partdb.sql
echo "Aanmaken gebruikers naar PartDB" 2>&1 | tee -a $LOGFILE
sudo mysql -u root -p < ~/tmp/create_userPartDb.sql
echo "PartDB geïnstalleerd bij http://$_hn1.local/support/part-db" 2>&1 | tee -a $LOGFILE
echo "   Frontend met gebruikersnaam: admin, wachtwoord: admin"
echo "   Partdb setup aanmelden met gebruikersnaam: partdb, wachtwoord: partdb"
sudo rm -rf ~/Downloads/part-db.tar.gz
sudo rm -rf ~/Downloads/'vendor.zip?raw=true'
cd $_pwd
