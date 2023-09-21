#!/bin/bash
LOGFILE=$HOME/logs/backupVanAlles-`date +%Y-%m-%d_%Hh%Mm`.log
BACKUPDIR=/mnt/usb0/rugsteun
BACKUPFILE=$(hostname)_backup.7z
sudo mkdir /mnt/usb0  2>&1 | tee -a $LOGFILE
sudo mkdir /mnt/usb0/rugsteun  2>&1 | tee -a $LOGFILE
lsblk -fp  2>&1 | tee -a $LOGFILE
sudo blkid  2>&1 | tee -a $LOGFILE
# sudo mount -t auto -o defaults  /dev/sda1 /mnt/usb0/  2>&1 | tee -a $LOGFILE
sudo cp /mnt/usb0/rugsteun/$(hostname)_backup.7z /mnt/usb0/rugsteun/$(hostname)_backup_oud.7z  2>&1 | tee -a $LOGFILE
sudo cp -v /mnt/usb0/rugsteun/*_backup.7z /mnt/usb0/rugsteun/  2>&1 | tee -a $LOGFILE
echo "7z a /mnt/usb0/rugsteun/$(hostname)_backup.7z" 2>&1 | tee -a $LOGFILE

# for addonnodes in ~/dbs ~/.octoprint ~/.homeassistant  ~/.node-red/ ~.npm/ ~/single_chan_pkt_fwd/ ~/venv /~.local ~/Programmering/ /~.micropython  /var/www/html/support/nextcloud/data /var/lib/mysql/   ; do
#   echo "" 2>&1 | tee -a $LOGFILE
#   echo "" 2>&1 | tee -a $LOGFILE
#   echo "backupen van dir ${addonnodes}" 2>&1 | tee -a $LOGFILE
#   echo "" 2>&1 | tee -a $LOGFILE
#   sudo 7z a $BACKUPDIR/rugsteun_${hostname}_${addonnodes}.7z -r  ${addonnodes}  2>&1 | tee -a $LOGFILE
#   echo "updaten van dir ${addonnodes}" 2>&1 | tee -a $LOGFILE
#   sudo 7z u $BACKUPDIR/$BACKUPFILE -r   ${addonnodes}  2>&1 | tee -a $LOGFILE
# done

7z a $BACKUPDIR/$(hostname)_dbs_backup.7z -r  /home/pi/dbs  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_.octoprint_backup.7z -r  /home/pi/.octoprint  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_.homeassistant_backup.7z -r  /home/pi/.homeassistant  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_.node-red_backup.7z -r  /home/pi/.node-red  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_.npm_backup.7z -r  /home/pi/.npm  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_single_chan_pkt_fwd_backup.7z -r  /home/pi/single_chan_pkt_fwd  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_.venv_backup.7z -r  /home/pi/.venv  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_.local_backup.7z -r  /home/pi/.local  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_Programmering_backup.7z -r  /home/pi/Programmering  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_micropython_backup.7z -r  /home/pi/.micropython  2>&1 | tee -a $LOGFILE
sudo 7z a $BACKUPDIR/$(hostname)_userLocal_backup.7z -r  /usr/local  2>&1 | tee -a $LOGFILE
sudo 7z a $BACKUPDIR/$(hostname)__var_www_html_support_nextcloud_data_backup.7z -r  /var/www/html/support/nextcloud/data  2>&1 | tee -a $LOGFILE
sudo 7z a $BACKUPDIR/$(hostname)_var_lib_mysql_backup.7z -r  /var/lib/mysql/   2>&1 | tee -a $LOGFILE

# ~/.octoprint ~/.homeassistant  ~/.node-red/ ~/.npm/ ~/single_chan_pkt_fwd/ ~/venv /~.local ~/Programmering/ /~.micropython  /var/www/html/support/nextcloud/data /var/lib/mysql/   ; do

echo "Backup octopi" 2>&1 | tee -a $LOGFILE
octopiDir=/mnt/nfs/octopi/pi
for addonnodes in $octopiDir/dbs /mnt/nfs/octopi/pi/.octoprint    ; do
  echo "Backup octopi map: $addonnodes" 2>&1 | tee -a $LOGFILE
  sudo 7z a /mnt/usb0/rugsteun/server_octopi_backup.7z -r  ${addonnodes}
done

echo "Verwijderen tmp-bestanden" 2>&1 | tee -a $LOGFILE
sudo rm -rf "/mnt/usb0/rugsteun/*.tm"* 2>&1 | tee -a $LOGFILE
sudo rm -rf "/mnt/usb0/rugsteun/*.tm*" 2>&1 | tee -a $LOGFILE

echo "backup afgerond."  2>&1 | tee -a $LOGFILE
