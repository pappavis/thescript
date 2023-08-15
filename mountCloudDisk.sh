
#!/bin/sh
## ref --> https://github.com/permyakovaa/yandex_disk_backup   20230815

export  RSYNC_DIRECTORY_DIR=/home/pi/yandex.disk
echo "" 2>&1 | tee -a $LOGFILE
echo "** Installeren https://disk.yandex.ru" 2>&1 | tee -a $LOGFILE
sudo apt-get install -y davfs2 2>&1 | tee -a $LOGFILE
mkdir /home/pi/yandex.disk 2>&1 | tee -a $LOGFILE
echo "https://webdav.yandex.ru michiel@voorspoed.ru password"  2>&1 | tee -a  /etc/davfs2/secrets
sudo sed -i -e '/# use_locks/s/# //' /etc/davfs2/davfs2.conf 2>&1 | tee -a $LOGFILE
sudo usermod -aG davfs2 pi 2>&1 | tee -a $LOGFILE
sudo chmod 600 /etc/davfs2/secrets 2>&1 | tee -a $LOGFILE
sudo mount -t davfs https://webdav.yandex.ru /home/pi/yandex.disk 2>&1 | tee -a $LOGFILE
cd /home/pi/yandex.disk 
git clone https://github.com/permyakovaa/yandex_disk_backup.git 2>&1 | tee -a $LOGFILE
cp variables.sh.dist variables.sh 2>&1 | tee -a $LOGFILE
echo "YANDEX_DISK_SOURCE_DIR=/home/pi/yandex.disk" 2>&1 | tee -a /home/pi/yandex.disk/variables.sh
echo "RSYNC_DESTINATION_DIR=/home/pi/yandex.disk" 2>&1 | tee -a /home/pi/yandex.disk/variables.sh
echo "TELEGRAM_BOT_SECRET=your_telegram_bot_secret" 2>&1 | tee -a /home/pi/yandex.disk/variables.sh
echo "TELEGRAM_CHAT_ID=your_telegram_chat_id" 2>&1 | tee -a /home/pi/yandex.disk/variables.sh
echo "Einde mountCloudDisk.sh" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
