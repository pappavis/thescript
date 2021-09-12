_id1=$(id pi)
_hn1=$(hostname)
_ip1=$(hostname -I)
mkdir ~/tmp
printf "\nStart instellen van NFS server op \n" $_ip1 ".local\n"
sudo apt-get install -y nfs-kernel-server nfs-common
sudo mkdir /mnt/nfsshare
sudo chown -R nobody:nogroup /mnt/nfsshare/
sudo chmod 777 /mnt/nfsshare/
sudo cp /etc/exports ~/tmp/exp1.tmp
sudo exportfs -ra
sudo service nfs-server restart
sudo systemctl restart nfs-kernel-server

printf "\nProbeer netwerk share te mount op /mnt\n"
sudo mount -t nfs -o proto=tcp,port=2049 pilamp.local:/nfsshare /mnt &
sudo mount -t nfs -o proto=tcp,port=2049 pi0.local:/nfsshare /mnt &
sudo mount -t nfs -o proto=tcp,port=2049 pivhere.local:/nfsshare /mnt &
sudo mount -t nfs -o proto=tcp,port=2049 retropie.local:/nfsshare /mnt &
sudo mount -t nfs -o proto=tcp,port=2049 p1mon.local:/nfsshare /mnt &

sudo printf "\n HANDMATIG toevoegen aan /etc/exports/  : \n/mnt/nfsshare *(rw,all_squash,insecure,async,no_subtree_check,anonuid=1000,anongid=1000)\n"
printf "\nNFS bestanddeling is daarna bereikbaar:\n -- MacOS verbind aan nfs://$_hn1.local/nfsshare  of nfs://$_ip1/nfsshare \n -- Windows verbind aan //$ip1.local/nfsshare\n\nIP adres $_ip1\n"
printf "\nHandmatig uitvoeren:\n  sudo service nfs-server restart\n"


