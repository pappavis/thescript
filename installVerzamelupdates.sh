LOGFILE=$HOME/installVerzamelupdates-`date +%Y-%m-%d_%Hh%Mm`.log

sudo apt autoclean -y
sudo apt autoremove -y

printf "\n** 20210904 Bijwerken Python, Circuitpython, instalaltie Micropython\n**"
sudo apt update -y
mkdir ~/Downloads
cd ~/Downloads
git clone https://github.com/pappavis/thescript
cd ~/Downloads/thescript
git pull
printf "\nInstalleren VirtualHere.com USB via WiFi.\n"
bash ./installExtras.sh
bash ./installNFSserver.sh

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
sudo apt autoclean -y
sudo apt autoremove -y
bash ./installOctoprint.sh
bash ./installOctoprintWebcam.sh
bash ./installHomeassistant.sh
bash ./installHomebridgeApple.sh
bash ./installNodered.sh
printf "\nTesseract OCR wordt bijgewerkt\n"
bash ./installTessarectOCR.sh &
sudo apt autoclean -y
sudo apt autoremove -y

printf "Let op!!  Apple Homebridge & Homeassistantop Pi 3 model A installeren, dan swapfile uitbreiden naar 1Gb!!\n"
printf "\nEINDE installVerzamelupdates.sh afgerond.\n"
