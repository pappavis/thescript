#!/bin/bash
LOGFILE=$HOME/logs/backupVanAlles-`date +%Y-%m-%d_%Hh%Mm`.log
BACKUPDIR=/mnt/usb0/rugsteun
BACKUPFILE=$(hostname)_backup.7z
sudo mkdir /mnt/usb0  2>&1 | tee -a $LOGFILE
sudo mkdir /mnt/usb0/rugsteun  2>&1 | tee -a $LOGFILE
lsblk -fp  2>&1 | tee -a $LOGFILE
sudo blkid  2>&1 | tee -a $LOGFILE
sudo mount -t auto -o defaults  /dev/sda1 /mnt/usb0/  2>&1 | tee -a $LOGFILE
sudo cp /mnt/usb0/rugsteun/$(hostname)_backup.7z /mnt/usb0/rugsteun/$(hostname)_backup_oud.7z  2>&1 | tee -a $LOGFILE
echo "7z a /mnt/usb0/rugsteun/$(hostname)_backup.7z" 2>&1 | tee -a $LOGFILE

for addonnodes in ~/dbs ~/.octoprint ~/.homeassistant  ~/.node-red/ ~.npm/ ~/single_chan_pkt_fwd/ ~/venv /~.local ~/Programmering/ /~.micropython  /var/www/html/support/nextcloud/data /var/lib/mysql/   ; do
  echo "" 2>&1 | tee -a $LOGFILE
  echo "" 2>&1 | tee -a $LOGFILE
  echo "backupen van dir ${addonnodes}" 2>&1 | tee -a $LOGFILE
  echo "" 2>&1 | tee -a $LOGFILE
  sudo 7z a $BACKUPDIR/$BACKUPFILE -r   ${addonnodes}  2>&1 | tee -a $LOGFILE
  echo "updaten van dir ${addonnodes}" 2>&1 | tee -a $LOGFILE
  sudo 7z u $BACKUPDIR/$BACKUPFILE -r   ${addonnodes}  2>&1 | tee -a $LOGFILE
done

echo "Backup octopi" 2>&1 | tee -a $LOGFILE
octopiDir=/mnt/nfs/octopi/pi
for addonnodes in $octopiDir/dbs /mnt/nfs/octopi/pi/.octoprint    ; do
  echo "Backup octopi map: $addonnodes" 2>&1 | tee -a $LOGFILE
  sudo 7z a /mnt/usb0/rugsteun/octopi_backup.7z -r  ${addonnodes}
done

echo "Verwijderen tmp-bestanden" 2>&1 | tee -a $LOGFILE
sudo rm -rf "/mnt/usb0/rugsteun/*.tm"* 2>&1 | tee -a $LOGFILE
sudo rm -rf "/mnt/usb0/rugsteun/*.tm*" 2>&1 | tee -a $LOGFILE

echo "backup afgerond."  2>&1 | tee -a $LOGFILE
