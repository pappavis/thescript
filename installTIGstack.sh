#!/bin/bash
_hn1=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/installTIGstack-`date +%Y-%m-%d_%Hh%Mm`.log
AQUIET=""

mkdir ~/logs
git pull

echo "********* Start installTIGstack -->  $LOGFILE" 2>&1 | tee -a $LOGFILE

cd ~/Downloads/
echo "* Installeren chronograf" 2>&1 | tee -a $LOGFILE
wget wget  https://dl.influxdata.com/chronograf/releases/chronograf-1.9.4_linux_armhf.tar.gz  2>&1 | tee -a $LOGFILE
tar xf ./chronograf-1.9.4_linux_armhf.tar.gz
sudo cp -R ./chronograf-1.9.4-1/* /  2>&1 | tee -a $LOGFILE
wget https://raw.githubusercontent.com/pappavis/thescript/master/services/chronograf.service 2>&1 | tee -a $LOGFILE
sudo mv ./chronograf.service /etc/systemd/system 2>&1 | tee -a $LOGFILE
sudo systemctl enable chronograf
sudo systemctl start chronograf
sudo systemctl status chronograf 2>&1 | tee -a $LOGFILE
sudo docker pull chronograf:1.9  2>&1 | tee -a $LOGFILE
rm -rf ./chronograf-1.9.4*


cd ~/Downloads/
echo "* Installeer telegraf" 2>&1 | tee -a $LOGFILE
wget wget https://dl.influxdata.com/telegraf/releases/telegraf-1.22.4_linux_armhf.tar.gz  2>&1 | tee -a $LOGFILE
tar xf ./telegraf-1.22.4_linux_armhf.tar.gz
sudo cp -R -v ./telegraf-1.22.4/* /  2>&1 | tee -a $LOGFILE
wget https://raw.githubusercontent.com/pappavis/thescript/master/services/telegraf.service 2>&1 | tee -a $LOGFILE
sudo mv ./telegraf.service /etc/systemd/system 2>&1 | tee -a $LOGFILE
sudo systemctl enable telegraf
sudo systemctl start telegraf
sudo systemctl status telegraf 2>&1 | tee -a $LOGFILE
rm -rf ./telegraf-1.22.4*

_tg_conf=$('[[outputs.influxdb]] \
   urls = ["http://127.0.0.1:8086"] \
   database = "telegraf" \
   username = "telegrafuser" \
   password = "Telegr@f" \
  ')
echo $_tg_conf | sudo tee -a /etc/telegraf/telegraf.conf 2>&1 | tee -a $LOGFILE
sudo service telegraf restart
sudo service telegraf status 2>&1 | tee -a $LOGFILE


cd ~/Downloads/
echo "* Installeer influxdb" 2>&1 | tee -a $LOGFILE
echo "deb [signed-by=/usr/share/keyrings/influxdb-archive-keyring.gpg] https://repos.influxdata.com/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt update -y 2>&1 | tee -a $LOGFILE
sudo apt install influxdb -y 2>&1 | tee -a $LOGFILE
sudo systemctl enable influxdb
sudo systemctl start influxdb
sudo service influxdb status 2>&1 | tee -a $LOGFILE
## https://nwmichl.net/2020/07/14/telegraf-influxdb-grafana-on-raspberrypi-from-scratch/
sudo usermod -a -G video telegraf

echo "Setup telegraf database op InfluxDB"  2>&1 | tee -a $LOGFILE
tg_db=$"create database telegraf; use telegraf;  create user telegrafuser with password 'Telegr@f' with all privileges; grant all privileges on telegraf to telegrafuser; create retention policy '4Weeks' on 'telegraf' duration 4w replication 1 default; exit;"
influx -execute $tg_db   2>&1 | tee -a $LOGFILE
echo "create database telegraf;" | influx 2>&1 | tee -a $LOGFILE
echo "use telegraf" | influx 2>&1 | tee -a $LOGFILE
echo "create user telegrafuser with password 'Telegr@f' with all privileges; " | influx 2>&1 | tee -a $LOGFILE
echo "grant all privileges on telegraf to telegrafuser; " | influx
echo "create retention policy '4Weeks' on 'telegraf' duration 4w replication 1 default; " | influx 2>&1 | tee -a $LOGFILE

cd ~/Downloads/
echo "* Installeer grafana" 2>&1 | tee -a $LOGFILE
sudo wget https://dl.grafana.com/oss/release/grafana-rpi_6.6.1_armhf.deb 2>&1 | tee -a $LOGFILE
sudo dpkg -i ./grafana-rpi_6.6.1_armhf.deb 2>&1 | tee -a $LOGFILE
sudo systemctl enable grafana-server 2>&1 | tee -a $LOGFILE
sudo systemctl status grafana-server 2>&1 | tee -a $LOGFILE
echo "grafana-server is geïnstalleerd op http://$(hostname).local:3000" 2>&1 | tee -a $LOGFILE
sudo usermod -a -G video telegraf

cd $_pwd

echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "* Grafana URL --> http://$(hostname).local:3000/" 2>&1 | tee -a $LOGFILE
echo "* Chronograf URL --> http://$(hostname).local:8888/" 2>&1 | tee -a $LOGFILE
echo "* Telegraf --> $(hostname).local/" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE


echo "* installTIGstack is afgerond." 2>&1 | tee -a $LOGFILE

cd $_pwd
