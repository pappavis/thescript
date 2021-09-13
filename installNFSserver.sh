_id1=$(id pi)
_hn1=$(hostname)
_ip1=$(hostname -I)
mkdir ~/tmp
printf "\nStart instellen van NFS server op \n" $_ip1 ".local\n"
sudo apt-get install -y nfs-kernel-server nfs-common firewalld
sudo mkdir /mnt/nfsshare
sudo chown -R nobody:nogroup /mnt/nfsshare/
sudo chmod 777 /mnt/nfsshare/
sudo cp /etc/exports ~/tmp/exp1.tmp
sudo exportfs -ra
sudo service nfs-server restart
sudo systemctl restart nfs-kernel-server

sudo firewall-cmd --permanent --zone=public --add-service=nfs
sudo firewall-cmd --permanent --zone=public --add-service=mountd
sudo firewall-cmd --permanent --zone=public --add-service=rpc-bind
sudo firewall-cmd --reload

sudo mkdir -p /mnt/acer01/
sudo mkdir -p /mnt/pi0/
sudo mkdir -p /mnt/pivhere/
sudo mkdir -p /mnt/dietpi/
sudo mkdir -p /mnt/pi4/
sudo mkdir -p /mnt/pilamp/

printf "\nProbeer netwerk share te mount op /mnt\n"
sudo mount -t auto acer01:/home /mnt/acer01/ &
sudo mount -t auto acer01:/home /mnt/pi0/ &
sudo mount -t auto acer01:/home /mnt/pivhere/ &
sudo mount -t auto acer01:/home /mnt/pi4/ &
sudo mount -t auto acer01:/home /mnt/pilamp/ &

sudo printf "\n HANDMATIG toevoegen aan /etc/exports/  : \n/mnt/nfsshare *(rw,all_squash,insecure,async,no_subtree_check,anonuid=1000,anongid=1000)\n"
printf "\nNFS bestanddeling is daarna bereikbaar:\n -- MacOS verbind aan nfs://$_hn1.local/nfsshare  of nfs://$_ip1/nfsshare \n -- Windows verbind aan //$ip1.local/nfsshare\n\nIP adres $_ip1\n"
printf "\nHandmatig uitvoeren:\n  sudo service nfs-server restart\n"


