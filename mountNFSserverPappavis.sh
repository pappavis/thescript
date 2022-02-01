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
