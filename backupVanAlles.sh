#!/bin/bash
LOGFILE=$HOME/logs/backupVanAlles-`date +%Y-%m-%d_%Hh%Mm`.log
sudo mkdir /mnt/usb0  2>&1 | tee -a $LOGFILE
sudo mkdir /mnt/usb0/rugsteun  2>&1 | tee -a $LOGFILE
lsblk -fp  2>&1 | tee -a $LOGFILE
sudo blkid  2>&1 | tee -a $LOGFILE
sudo mount -t auto -o defaults  /dev/sda1 /mnt/usb0/  2>&1 | tee -a $LOGFILE
sudo cp /mnt/usb0/rugsteun/dietpi_backup.7z /mnt/usb0/rugsteun/dietpi_backup_oud.7z  2>&1 | tee -a $LOGFILE
sudo 7z a /mnt/usb0/rugsteun/dietpi_backup.7z -r ~/dbs ~/.octoprint ~/.homeassistant  ~/.node-red/ ~.npm/ ~/single_chan_pkt_fwd/ ~/venv /~.local ~/Programmering/ /~.micropython   2>&1 | tee -a $LOGFILE
sudo 7z u /mnt/usb0/rugsteun/dietpi_backup.7z -r ~/dbs ~/.octoprint ~/.homeassistant  ~/.node-red/ ~.npm/ ~/single_chan_pkt_fwd/ ~/venv /~.local ~/Programmering/ /~.micropython   2>&1 | tee -a $LOGFILE
echo "backup afgerond"  2>&1 | tee -a $LOGFILE
