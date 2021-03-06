echo " "
echo "SETUP: part-db in /var/www/html/"
echo " "
cd ~/Downloads
wget -O part-db.tar.gz https://github.com/jbtronics/Part-DB/archive/master.tar.gz
sudo tar -xzf part-db.tar.gz -C /var/www/html/support
sudo mv /var/www/html/support/Part-DB-master /var/www/html/support/part-db
#sudo chown www-root:www-root /var/www/html/support/part-db -R
wget https://github.com/jbtronics/Part-DB/blob/gh-pages/vendor.zip?raw=true
7z x 'vendor.zip?raw=true'
sudo mv ./vendor  /var/www/html/support/part-db
cd  /var/www/html/support/part-db
sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php
sudo php -r "unlink('composer-setup.php');"
sudo chown -R www-data:www-data /var/www/html/support/part-db
cd ~/Downloads
wget https://github.com/pappavis/Part-DB/blob/master/db/partdb.sql
