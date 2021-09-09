_id1=$(id pi)
_hn1=$(hostname)
_ip1=$(hostname -I)
printf "\nStart instellen van NFS server op \n" $_ip1 ".local\n"
sudo apt-get install nfs-kernel-server -y
sudo mkdir /mnt/nfsshare
sudo chown -R pi:pi /mnt/nfsshare
sudo find /mnt/nfsshare/ -type d -exec chmod 755 {} \;
sudo find /mnt/nfsshare/ -type f -exec chmod 644 {} \;
sudo printf "\n/mnt/nfsshare *(rw,all_squash,insecure,async,no_subtree_check,anonuid=1000,anongid=1000)\n" >> /etc/exports
sudo exportfs -ra
printf "\nNFS bestanddeling is ingesteld\n -- MacOS verbind aan nfs://$_hn1.local/nfsshare  of nfs://$_ip1/nfsshare \n -- Windows verbind aan //$ip1.local/nfsshare\n\nIP adres $_ip1\n"
udo service nfs-server restart
