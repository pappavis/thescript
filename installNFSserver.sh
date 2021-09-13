_id1=$(id pi)
_hn1=$(hostname)
_ip1=$(hostname -I)
mkdir ~/tmp
printf "\nStart instellen van NFS server op \n" $_ip1 ".local\n"
sudo apt-get install -y nfs-kernel-server nfs-common firewalld
sudo mkdir /mnt/nfs/nfsshare
sudo chown -R nobody:nogroup /mnt/nfs/nfsshare/
sudo chmod 777 /mnt/nfs/nfsshare/
sudo cp /etc/exports ~/tmp/exp1.tmp
sudo exportfs -ra
sudo service nfs-server restart
sudo systemctl restart nfs-kernel-server

sudo firewall-cmd --permanent --zone=public --add-service=nfs
sudo firewall-cmd --permanent --zone=public --add-service=mountd
sudo firewall-cmd --permanent --zone=public --add-service=rpc-bind
sudo firewall-cmd --reload

sudo mkdir -p /mnt/nfs/acer01/
sudo mkdir -p /mnt/nfs/pi0/
sudo mkdir -p /mnt/nfs/pivhere/
sudo mkdir -p /mnt/nfs/dietpi/
sudo mkdir -p /mnt/nfs/pi4/
sudo mkdir -p /mnt/nfs/pilamp/
sudo mkdir -p /mnt/nfs/spelen02/

sudo chmod 777 /mnt/nfs/nfsshare/
sudo chmod 777 /mnt/nfs/acer01/
sudo chmod 777 /mnt/nfs/pi0/
sudo chmod 777 /mnt/nfs/pivhere/
sudo chmod 777 /mnt/nfs/pi4/
sudo chmod 777 /mnt/nfs/pilamp/
sudo chmod 777 /mnt/nfs/spelen02/


printf "\nProbeer netwerk share te mount op /mnt\n"
sudo mount -t auto acer01:/home /mnt/acer01/ &
sudo mount -t auto pi0:/home /mnt/pi0/ &
sudo mount -t auto pivhere:/home /mnt/pivhere/ &
sudo mount -t auto pi4:/home /mnt/pi4/ &
sudo mount -t auto pilamp:/home /mnt/pilamp/ &
sudo mount -t auto spelen02:/home /mnt/spelen02/ &

sudo printf "\n HANDMATIG toevoegen aan /etc/exports/  : \n/mnt/nfsshare *(rw,all_squash,insecure,async,no_subtree_check,anonuid=1000,anongid=1000)\n"
printf "\nNFS bestanddeling is daarna bereikbaar:\n -- MacOS verbind aan nfs://$_hn1.local/nfsshare  of nfs://$_ip1/nfsshare \n -- Windows verbind aan //$ip1.local/nfsshare\n\nIP adres $_ip1\n"
printf "\nHandmatig uitvoeren:\n  sudo service nfs-server restart\n"


