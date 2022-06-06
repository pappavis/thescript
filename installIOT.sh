LOGFILE=$HOME/logs/installIOT-`date +%Y-%m-%d_%Hh%Mm`.log
mkdir ~/logs


echo "* Start iot.db setup in sqlite3." 2>&1 | tee -a $LOGFILE
sudo apt install -y sqlite3 2>&1 | tee -a $LOGFILE

mkdir /home/pi/dbs
cd /home/pi/dbs
sudo wget https://raw.githubusercontent.com/pappavis/thescript/master/iot_db_aanmaken.sql   2>&1 | tee -a $LOGFILE
sudo wget https://raw.githubusercontent.com/pappavis/thescript/master/iot_temperature_record.sql 2>&1 | tee -a $LOGFILE

cat ./iot_db_aanmaken.sql | sudo sqlite3 /home/pi/dbs/iot.db   2>&1 | tee -a $LOGFILE
cat ./iot_temperature_record.sql | sudo sqlite3 /home/pi/dbs/iot.db   2>&1 | tee -a $LOGFILE
#wget https://github.com/pappavis/ESP8266_MQQT_Weerstation/blob/master/dbs/iot.db   2>&1 | tee -a $LOGFILE
sudo chmod 777 /home/pi/dbs -R
sudo chmod 666 /home/pi/dbs/iot.db
echo "sudo chmod -R u=rwx,g=rx,o=rx /home/pi/dbs"   2>&1 | tee -a $LOGFILE

echo "installIOT.sh afgerond"   2>&1 | tee -a $LOGFILE
echo ""   2>&1 | tee -a $LOGFILE

