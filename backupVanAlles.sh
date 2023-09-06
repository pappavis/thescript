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

# for addonnodes in ~/dbs ~/.octoprint ~/.homeassistant  ~/.node-red/ ~.npm/ ~/single_chan_pkt_fwd/ ~/venv /~.local ~/Programmering/ /~.micropython  /var/www/html/support/nextcloud/data /var/lib/mysql/   ; do
#   echo "" 2>&1 | tee -a $LOGFILE
#   echo "" 2>&1 | tee -a $LOGFILE
#   echo "backupen van dir ${addonnodes}" 2>&1 | tee -a $LOGFILE
#   echo "" 2>&1 | tee -a $LOGFILE
#   sudo 7z a $BACKUPDIR/rugsteun_${hostname}_${addonnodes}.7z -r  ${addonnodes}  2>&1 | tee -a $LOGFILE
#   echo "updaten van dir ${addonnodes}" 2>&1 | tee -a $LOGFILE
#   sudo 7z u $BACKUPDIR/$BACKUPFILE -r   ${addonnodes}  2>&1 | tee -a $LOGFILE
# done

7z a $BACKUPDIR/$(hostname)_dbs_backup.7z -r  ~/dbs  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_octoprint_backup.7z -r  ~/.octoprint  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_homeassistant_backup.7z -r  ~/.homeassistant  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_node-red_backup.7z -r  ~/.node-red  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_npm_backup.7z -r  ~/.npm  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_single_chan_pkt_fwd_backup.7z -r  ~/single_chan_pkt_fwd  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_venv_backup.7z -r  ~/venv  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_local_backup.7z -r  ~/.local  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_Programmering_backup.7z -r  ~/Programmering  2>&1 | tee -a $LOGFILE
7z a $BACKUPDIR/$(hostname)_micropython_backup.7z -r  ~/.micropython  2>&1 | tee -a $LOGFILE
sudo 7z a $BACKUPDIR/$(hostname)_userLocal_backup.7z -r  ~/usr/local  2>&1 | tee -a $LOGFILE
sudo 7z a $BACKUPDIR/$(hostname)_nextcloud_backup.7z -r  /var/www/html/support/nextcloud/data  2>&1 | tee -a $LOGFILE
sudo 7z a $BACKUPDIR/$(hostname)_mysql_backup.7z -r  /var/lib/mysql/   2>&1 | tee -a $LOGFILE

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
