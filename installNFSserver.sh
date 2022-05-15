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

for addonnodes in ict-beheer acer01 pi0 pivhere dietpi pi04 pilamp spelen02 p1mon retropie pi07 pi08 pi09 octopi $(hostname) ; do
  echo "" 2>&1 | tee -a $LOGFILE &
  echo "" 2>&1 | tee -a $LOGFILE &
  echo " NFS share aangemaakt sql database server: ${addonnodes}"  2>&1 | tee -a $LOGFILE &
  sudo mkdir -p /mnt/nfs/${addonnodes} 
  sudo mkdir -p /mnt/davfs2/${addonnodes}
  sudo mkdir /mnt/davfs2/service/
  sudo mkdir /mnt/davfs2/service/${addonnodes}
  sudo chmod +rw /mnt/nfs/${addonnodes} 
  sudo chmod +rw /mnt/davfs2/${addonnodes} 
  sudo chown -R pi:pi /mnt/nfs/${addonnodes} 
  sudo chown -R pi:pi /mnt/dafvs2/${addonnodes} 


  echo "Instellen certificate voor $addonnodes" 2>&1 | tee -a $LOGFILE
  echo "${addonnodes} ${pi} ${raspberry}" | sudo tee -a /etc/davfs2/secrets
  sudo chmod 600 /etc/davfs2/secrets  
    
  openssl s_client -showcerts -connect ${WEBDAV_SERVER_FQDN}:443  < /dev/null 2> /dev/null |    openssl x509 -outform PEM |  sudo tee /etc/davfs2/certs/${WEBDAV_SERVER_FQDN}.pem
  echo "trust_server_cert ${addonnodes}" |  sudo tee -a /etc/davfs2/davfs2.conf  2>&1 | tee -a $LOGFILE

  echo "Instellen automount service voor $addonnodes" 2>&1 | tee -a $LOGFILE
  sudo rm -rf /etc/systemd/system/mnt-webdav-service${addonnodes}.mount
  echo "[Unit]" |  sudo tee -a /etc/systemd/system/mnt-webdav-service${addonnodes}.mount
  echo "Description=Mount WebDAV Service ${addonnodes}" |  sudo tee -a /etc/systemd/system/mnt-webdav-service${addonnodes}.mount
  echo "After=network-online.target" |  sudo tee -a /etc/systemd/system/mnt-webdav-service${addonnodes}.mount
  echo "Wants=network-online.target" |  sudo tee -a /etc/systemd/system/mnt-webdav-service${addonnodes}.mount
  echo "" |  sudo tee -a /etc/systemd/system/mnt-webdav-service${addonnodes}.mount
  echo "[Mount]" |  sudo tee -a /etc/systemd/system/mnt-webdav-service${addonnodes}.mount
  echo "What=http(s)://${addonnodes}.local/support/owncloud" |  sudo tee -a /etc/systemd/system/mnt-webdav-service${addonnodes}.mount
  echo "Where=/mnt/davfs2/service/${addonnodes}" |  sudo tee -a  /etc/systemd/system/mnt-webdav-service${addonnodes}.mount
  echo "Options=uid=1000,file_mode=0664,dir_mode=2775,grpid" |  sudo tee -a /etc/systemd/system/mnt-webdav-service${addonnodes}.mount
  echo "Type=davfs" |  sudo tee -a /etc/systemd/system/mnt-webdav-service${addonnodes}.mount
  echo "TimeoutSec=15" |  sudo tee -a /etc/systemd/system/mnt-webdav-service${addonnodes}.mount
  echo "" |  sudo tee -a /etc/systemd/system/mnt-webdav-service${addonnodes}.mount
  echo "[Install]" |  sudo tee -a /etc/systemd/system/mnt-webdav-service${addonnodes}.mount 
  echo "WantedBy=multi-user.target" |  sudo tee -a /etc/systemd/system/mnt-webdav-service${addonnodes}.mount
  sudo sysctl enable mnt-webdav-service${addonnodes}
  sudo service mnt-webdav-service${addonnodes} restart
  sudo service mnt-webdav-service${addonnodes} status  2>&1 | tee -a $LOGFILE

  echo "http://${addonnodes}.local/support/owncloud pi raspberry" | sudo tee -a /etc/davfs2/secrets
  sudo chmod 600 /etc/davfs2/secrets
  chown root:root /etc/davfs2/secrets
  chmod 600 ~/.davfs2/secrets

  sudo find /mnt/nfs/ -type d -exec chmod 755 {} \;
  sudo find /mnt/nfs/ -type f -exec chmod 644 {} \;

  echo "" 2>&1 | tee -a $LOGFILE &
  echo "" 2>&1 | tee -a $LOGFILE &
done

echo "Instellen NFSrechten op $_ip1"  2>&1 | tee -a $LOGFILE
#sudo chown nobody:nogroup /mnt/nfs
sudo cp /etc/exports ~/tmp/exp1.tmp 2>&1 | tee -a $LOGFILE
echo "/home *(rw,all_squash,insecure,async,no_subtree_check,anonuid=1000,anongid=1000)"  2>&1 | sudo tee -a /etc/exports  2>&1 | tee -a $LOGFILE 
sudo exportfs -ra   2>&1 | tee -a $LOGFILE
sudo service nfs-server restart 
sudo service rpcbind restart
sudo service nfs-kernel-server restart 
sudo service nfs-server status   2>&1 | tee -a $LOGFILE

#sudo chmod 777 -R /mnt/nfs/
bash ./mountNFSserverPappavis.sh  2>&1 | tee -a $LOGFILE

printf "\nNFS bestanddeling is daarna bereikbaar:\n -- MacOS verbind aan http://$(hostname).local/nfs  of nfs://$(hostname -I)/nfs \n -- Windows verbind aan //$(hostname).local/nfs\n\nIP adres $(hostname -I)\n"   2>&1 | tee -a $LOGFILE
printf "\nHandmatig uitvoeren:\n  sudo service nfs-server restart\n" 2>&1 | tee -a $LOGFILE
sudo service nfs-server restart 2>&1 | tee -a $LOGFILE


