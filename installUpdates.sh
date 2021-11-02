printf "Laatste versies worden opgehaal en geinstalleerd.\n"
sudo apt update -y
sudo apt upgrade -y
sudo apt autoclean -y
sudo apt autoremove -y

printf "NodeJS wordt bijgewerkt naar de laatste versie\n"
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt install -y nodejs
sudo apt install -y build-essential
printf "installUpdates.sh afgerond.\n"
printf "Werkt die NodeJS installatie?\n"
curl -fsSL https://deb.nodesource.com/test | bash -
printf "NodeJS test install afgerond.\n"
sudo apt full-upgrade -y
