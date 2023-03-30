#!/bin/bash
LOGFILE=$HOME/logs/backupVanAlles-`date +%Y-%m-%d_%Hh%Mm`.log
BACKUPDIR=/mnt/usb0/rugsteun/$(hostname)_backup.7z
sudo mkdir /mnt/usb0  2>&1 | tee -a $LOGFILE
sudo mkdir /mnt/usb0/rugsteun  2>&1 | tee -a $LOGFILE
lsblk -fp  2>&1 | tee -a $LOGFILE
sudo blkid  2>&1 | tee -a $LOGFILE
sudo mount -t auto -o defaults  /dev/sda1 /mnt/usb0/  2>&1 | tee -a $LOGFILE
sudo cp /mnt/usb0/rugsteun/$(hostname)_backup.7z /mnt/usb0/rugsteun/$(hostname)_backup_oud.7z  2>&1 | tee -a $LOGFILE
echo "7z a /mnt/usb0/rugsteun/$(hostname)_backup.7z" 2>&1 | tee -a $LOGFILE

for addonnodes in ~/dbs ~/.octoprint ~/.homeassistant  ~/.node-red/ ~.npm/ ~/single_chan_pkt_fwd/ ~/venv /~.local ~/Programmering/ /~.micropython   ; do
  echo "" 2>&1 | tee -a $LOGFILE
  echo "" 2>&1 | tee -a $LOGFILE
  echo "backupen van dir ${addonnodes}" 2>&1 | tee -a $LOGFILE
  echo "" 2>&1 | tee -a $LOGFILE
  sudo 7z a /mnt/usb0/rugsteun/$(hostname)_backup.7z -r   ${addonnodes}  2>&1 | tee -a $LOGFILE
  echo "updaten van dir ${addonnodes}" 2>&1 | tee -a $LOGFILE
  sudo 7z a /mnt/usb0/rugsteun/$(hostname)_backup.7z -r   ${addonnodes}  2>&1 | tee -a $LOGFILE
done

echo "backup afgerond"  2>&1 | tee -a $LOGFILE
