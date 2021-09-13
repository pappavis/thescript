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
printf "\nTesseract OCR wordt bijgewerkt\n"
bash ./installTessarectOCT.sh
printf "\nCircuitPython wordt bijgewerkt\n"
bash ./installPythonCircuitpython.sh
printf "\nPython wordt bijgewerkt\n"
bash ./installPythonVirtualenv.sh
bash ./installNodeJS.sh
printf "\Micropython wordt geïnstalleerd\n"
bash ./installMicropython.sh

printf "Let op!!  Apple Homebridge & Homeassistant niet op Pi 3 model A  installeren, hij heeft te weinig geheugen!!\n"
printf "\nEINDE installVerzamelupdates.sh afgerond.\n"
