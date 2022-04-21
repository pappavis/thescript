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
sudo mkdir -p /mnt/nfs/octopi/

#sudo chmod 777 -R /mnt/nfs/
./mountNFSserverPappavis.sh  2>&1 | tee -a $LOGFILE

echo "/home *(rw,all_squash,insecure,async,no_subtree_check)"  2>&1 | sudo tee -a /etc/exports  2>&1 | tee -a $LOGFILE  /home *(rw,all_squash,insecure,async,no_subtree_check)

sudo printf "\n HANDMATIG toevoegen aan /etc/exports/  : \n/home *(rw,all_squash,insecure,async,no_subtree_check)\n"  2>&1 | tee -a $LOGFILE
printf "\nNFS bestanddeling is daarna bereikbaar:\n -- MacOS verbind aan nfs://$(hostname).local/nfsshare  of nfs://$(hostname -I)/nfsshare \n -- Windows verbind aan //$(hostname).local/nfsshare\n\nIP adres $(hostname -I)\n"   2>&1 | tee -a $LOGFILE
printf "\nHandmatig uitvoeren:\n  sudo service nfs-server restart\n" 2>&1 | tee -a $LOGFILE
sudo service nfs-server restart 2>&1 | tee -a $LOGFILE


