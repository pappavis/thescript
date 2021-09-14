echo 'Loop nu reinstall script voor alle versies van MariaDB SQL Server'
echo 'Verwijderen MariaDB Server Software'
ehco '#sudo apt --remove purge mariadb-server* -y' 
echo 'Verwijder vorige MariaDB Server instalalties....'
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt clean all 
sudo rm -rf /etc/mysql/ /var/lib/mysql/ /var/log/mysql
sudo apt clean 
sudo apt install mariadb-server mariadb-client   -y
echo 'Installeer MariaDB Server overnieuw...'
sudo apt update -y
printf "doen\n sudo mysql_secure installation\n"
sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password password rider506'
sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password rider506'
echo 'MariaDB SQL Server herinstallatie afgerond'
