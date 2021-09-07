printf "\nInstalleren PHPmyadmin voor nginix webserver\n"
sudo apt-get install -y phpmyadmin
sudo ln -s /usr/share/phpmyadmin /var/www/html
_hn=$(hostname)
printf "PHPmyadmin admin afgerond. Bereikbaar op http://$_hn.local/phpmyadmin\n"
