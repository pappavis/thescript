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

sudo mkdir /mnt/nfs 2>&1 | tee -a $LOGFILE
sudo mkdir /mnt/davfs2 2>&1 | tee -a $LOGFILE

for addonnodes in acer01 pi0 pivhere dietpi pi04 pilamp spelen02 p1mon retropie pi07 pi08 pi09 octopi $(hostname) ; do
  echo "" 2>&1 | tee -a $LOGFILE &
  echo "" 2>&1 | tee -a $LOGFILE &
  echo " NFS share aangemaakt sql database server: ${addonnodes}"  2>&1 | tee -a $LOGFILE &
  sudo mkdir -p /mnt/nfs/${addonnodes} 2>&1 | tee -a $LOGFILE &
  sudo mkdir -p /mnt/davfs2/${addonnodes} 2>&1 | tee -a $LOGFILE &
  echo "" 2>&1 | tee -a $LOGFILE &
done

echo "Instellen NFSrechten op $_ip1"  2>&1 | tee -a $LOGFILE
sudo chown nobody:nogroup /mnt/nfs
sudo cp /etc/exports ~/tmp/exp1.tmp 2>&1 | tee -a $LOGFILE
sudo exportfs -ra   2>&1 | tee -a $LOGFILE
sudo service nfs-server restart 
sudo service rpcbind restart
sudo service nfs-kernel-server restart 

#sudo chmod 777 -R /mnt/nfs/
./mountNFSserverPappavis.sh  2>&1 | tee -a $LOGFILE

echo "/home *(rw,all_squash,insecure,async,no_subtree_check)"  2>&1 | sudo tee -a /etc/exports  2>&1 | tee -a $LOGFILE 

sudo printf "\n HANDMATIG toevoegen aan /etc/exports/  : \n/home *(rw,all_squash,insecure,async,no_subtree_check)\n"  2>&1 | tee -a $LOGFILE
printf "\nNFS bestanddeling is daarna bereikbaar:\n -- MacOS verbind aan nfs://$(hostname).local/nfsshare  of nfs://$(hostname -I)/nfsshare \n -- Windows verbind aan //$(hostname).local/nfsshare\n\nIP adres $(hostname -I)\n"   2>&1 | tee -a $LOGFILE
printf "\nHandmatig uitvoeren:\n  sudo service nfs-server restart\n" 2>&1 | tee -a $LOGFILE
sudo service nfs-server restart 2>&1 | tee -a $LOGFILE


