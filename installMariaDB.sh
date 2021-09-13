echo 'Loop nu reinstall script voor alle versies van MariaDB SQL Server'
echo 'Verwijderen MariaDB Server Software'
sudo apt --remove purge mariadb-server* -y
echo 'Verwijder vorige MariaDB Server instalalties....'
sudo apt -y autoremove 
sudo apt autoclean
sudo apt clean all 
sudo rm -rf /etc/mysql/ /var/lib/mysql/ /var/log/mysql
sudo apt clean 
echo 'Installeer MariaDB Server 10.3 overnieuw...'
sudo apt update -y
sudo debconf-set-selections <<< 'mariadb-server-10.3 mysql-server/root_password password rider506'
sudo debconf-set-selections <<< 'mariadb-server-10.3 mysql-server/root_password_again password rider506'
sudo apt install mariadb-server  -y
sudo apt install mariadb-client  -y
echo 'MariaDB SQL Server herinstallatie afgerond'
