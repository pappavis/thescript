#!/bin/bash
_id1=$(id pi)
_hn1=$(hostname)
_ip1=$(hostname -I)
LOGFILE=$HOME/logs/installNFSserver-`date +%Y-%m-%d_%Hh%Mm`.log
mkdir ~/logs

mkdir ~/tmp
printf "\nStart instellen van NFS server op \n" $_ip1 ".local\n"  2>&1 | tee -a $LOGFILE

for addonnodes in nfs-kernel-server nfs-common ; do
	echo "Installeren NFSserver vereisten:  \"${addonnodes}\""
	sudo apt install -y ${addonnodes}   2>&1 | tee -a $LOGFILE
done


echo "Instellen NFSrechten op $_ip1"  2>&1 | tee -a $LOGFILE
sudo mkdir /mnt/nfs
sudo chown nobody:nogroup /mnt/nfs
sudo cp /etc/exports ~/tmp/exp1.tmp 2>&1 | tee -a $LOGFILE
sudo exportfs -ra   2>&1 | tee -a $LOGFILE
sudo service nfs-server restart 
sudo service rpcbind restart
sudo service nfs-kernel-server restart 

sudo mkdir -p /mnt/nfs/acer01/
sudo mkdir -p /mnt/nfs/pi0/
sudo mkdir -p /mnt/nfs/pivhere/
sudo mkdir -p /mnt/nfs/dietpi/
sudo mkdir -p /mnt/nfs/pi4/
sudo mkdir -p /mnt/nfs/pilamp/
sudo mkdir -p /mnt/nfs/spelen02/
sudo mkdir -p /mnt/nfs/p1mon/
sudo mkdir -p /mnt/nfs/retropie/
sudo mkdir -p /mnt/nfs/pi07/
sudo mkdir -p /mnt/nfs/pi08/
sudo mkdir -p /mnt/nfs/pi09/

#sudo chmod 777 -R /mnt/nfs/

printf "\nProbeer netwerk share te mount op /mnt\n" 2>&1 | tee -a $LOGFILE
sudo mount -t auto acer01:/home /mnt/nfs/acer01/  2>&1 | tee -a $LOGFILE &
sudo mount -t auto pi0:/home /mnt/nfs/pi0/ &
sudo mount -t auto pivhere:/home /mnt/nfs/pivhere/ &
sudo mount -t auto pi04:/home /mnt/nfs/pi4/ &
sudo mount -t auto pilamp:/home /mnt/nfs/pilamp/ &
sudo mount -t auto spelen02:/home /mnt/nfs/spelen02/ &
sudo mount -t auto p1mon:/home /mnt/nfs/p1mon/ &
sudo mount -t auto retropie:/home /mnt/nfs/retropie/ &
sudo mount -t auto pi07:/home /mnt/nfs/pi07/ &
sudo mount -t auto pi08:/home /mnt/nfs/pi08/ &
sudo mount -t auto pi09:/home /mnt/nfs/pi09/ &

echo "/home *(rw,all_squash,insecure,async,no_subtree_check)"  2>&1 | tee -a $LOGFILE

sudo printf "\n HANDMATIG toevoegen aan /etc/exports/  : \n/home *(rw,all_squash,insecure,async,no_subtree_check)\n"  2>&1 | tee -a $LOGFILE
printf "\nNFS bestanddeling is daarna bereikbaar:\n -- MacOS verbind aan nfs://$_hn1.local/nfsshare  of nfs://$_ip1/nfsshare \n -- Windows verbind aan //$ip1.local/nfsshare\n\nIP adres $_ip1\n"   2>&1 | tee -a $LOGFILE
printf "\nHandmatig uitvoeren:\n  sudo service nfs-server restart\n" 2>&1 | tee -a $LOGFILE
sudo service nfs-server restart 2>&1 | tee -a $LOGFILE


