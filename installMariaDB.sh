LOGFILE=$HOME/logs/installMariaDB-`date +%Y-%m-%d_%Hh%Mm`.log

echo 'Loop nu reinstall script voor alle versies van MariaDB SQL Server' 2>&1 | tee -a $LOGFILE
echo 'Verwijderen MariaDB Server Software'
ehco '#sudo apt --remove purge mariadb-server* -y' 
echo 'Verwijder vorige MariaDB Server instalalties....'
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt clean all -y
sudo rm -rf /etc/mysql/ /var/lib/mysql/ /var/log/mysql
sudo apt clean -y

for addonnodes in mariadb-server mariadb-client ; do
  echo " "
  echo " "
  echo "Installeren sql database server: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

echo 'Installeer MariaDB Server overnieuw...'
sudo apt update -y
printf "doen\n sudo mysql_secure installation\n"
sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password password admin' 2>&1 | tee -a $LOGFILE
sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password admin' 2>&1 | tee -a $LOGFILE
echo 'MariaDB SQL Server herinstallatie afgerond' 2>&1 | tee -a $LOGFILE

