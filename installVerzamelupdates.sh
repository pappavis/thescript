printf "\n** 20210904 Bijwerken Python, Circuitpython, instalaltie Micropython\n**"
mkdir ~/Downloads
cd ~/Downloads
git clone https://github.com/pappavis/thescript
cd ~/Downloads/thescript
git pull
bash ./runmefirst
printf "\nInstalleren VirtualHere.com USB via WiFi.\n"
bash ./installExtras.sh
bash ./installNFSserver.sh
bash ./installNodeJS.sh
sudo apt autoclean -y
sudo apt autoremove -y
printf "\nTesseract OCR wordt bijgewerkt\n"
bash ./installTessarectOCT.sh
printf "\nCircuitPython wordt bijgewerkt\n"
bash ./installPythonCircuitpython.sh
printf "\nPython wordt bijgewerkt\n"
bash ./installPythonVirtualenv.sh
printf "\Micropython wordt geïnstalleerd\n"
bash ./installMicropython.sh
bash ./installPHPliteadmin.sh
bash ./installOwncloud.sh
bash ./installIOT.sh
bash ./installPythonLibs.sh
bash ./installUpdates.sh

printf "Let op!!  Apple Homebridge & Homeassistant niet op Pi 3 model A  installeren, hij heeft te weinig geheugen!!\n"
printf "\nEINDE installVerzamelupdates.sh afgerond.\n"
