#!/bin/bash
LOGFILE=~/logs/mountNFSserverPappavis.log

echo " "  2>&1 | tee -a $LOGFILE
echo " Start DAVfs en NFS shares mount op $(date)"  2>&1 | tee -a $LOGFILE

sudo mkdir /mnt/nfs/ 2>&1 | tee -a $LOGFILE
sudo mkdir /mnt/cifs/ 2>&1 | tee -a $LOGFILE


for addonnodes in ict-beheer acer01 pi0 pivhere dietpi pi04 pilamp spelen02 p1mon retropie pi07 pi08 pi09 octopi asusrouter $(hostname) ; do
  echo "" 2>&1 | tee -a $LOGFILE &
  echo "" 2>&1 | tee -a $LOGFILE &
  echo "Probeer netwerk share te mount op /mnt/nfs/${addonnodes}"  2>&1 | tee -a $LOGFILE
  sudo mkdir /mnt/nfs/${addonnodes}
  sudo mkdir /mnt/cifs/${addonnodes}
  sudo mount -t auto -o rw ${addonnodes}:/home  /mnt/nfs/${addonnodes} 2>&1 | tee -a $LOGFILE &
  sudo mount -t davfs -o,username=michiele rw http://${addonnodes}.local/support/owncloud/remote.php/webdav  /mnt/nfs/${addonnodes} 2>&1 | tee -a $LOGFILE &
  sudo mount -t cifs -o rw,username=pi /mnt/nfs/${addonnodes} 2>&1 | tee -a $LOGFILE &
  echo "" 2>&1 | tee -a $LOGFILE &
done


echo " EINDE DAVfs en NFS shares mount afgerond"  2>&1 | tee -a $LOGFILE
echo " "  2>&1 | tee -a $LOGFILE
