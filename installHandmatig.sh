#!/bin/bash
_hn1=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/installHandmatig-`date +%Y-%m-%d_%Hh%Mm`.log

APP_PASS="rider506"
ROOT_PASS="rider506"
APP_DB_PASS="rider506"

echo " " 2>&1 | tee -a $LOGFILE
echo " " 2>&1 | tee -a $LOGFILE
echo "Deze script moet je handmatig uitvoeren, gen backgroud taak.. dus niet: pizero$ nohup <<scriptnaam>.sh &  "
echo " " 2>&1 | tee -a $LOGFILE

# https://stackoverflow.com/questions/30741573/debconf-selections-for-phpmyadmin-unattended-installation-with-no-webserver-inst
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/internal/skip-preseed boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean false"
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $APP_PASS" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $ROOT_PASS" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $APP_DB_PASS" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo  debconf-set-selections


for addonnodes in  firebird-server postgresql  ; do
  echo " " 2>&1 | tee -a $LOGFILE
  echo " " 2>&1 | tee -a $LOGFILE
  echo "Installeren sql database server: ${addonnodes}"
  echo " " 2>&1 | tee -a $LOGFILE
  echo "admin\n" | sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo mysql_secureinstallation
sudo apt install -y phpmyadmin
