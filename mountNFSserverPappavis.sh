#!/bin/bash

echo " Start DAVfs en NFS shares mount."  2>&1 | tee -a $LOGFILE

for addonnodes in ict-beheer acer01 pi0 pivhere dietpi pi04 pilamp spelen02 p1mon retropie pi07 pi08 pi09 octopi $(hostname) ; do
  echo "" 2>&1 | tee -a $LOGFILE &
  echo "" 2>&1 | tee -a $LOGFILE &
  echo "Probeer netwerk share te mount op /mnt/nfs/${addonnodes}"  2>&1 | tee -a $LOGFILE
  sudo mount -t auto ${addonnodes}:/home  /mnt/nfs/${addonnodes} 2>&1 | tee -a $LOGFILE &
  sudo mount -t davfs ${addonnodes}.local/support/owncloud/remote.php/webdav  /mnt/nfs/${addonnodes} 2>&1 | tee -a $LOGFILE &
  echo "" 2>&1 | tee -a $LOGFILE &
done

echo " DAVfs en NFS shares mount afgerond"  2>&1 | tee -a $LOGFILE
