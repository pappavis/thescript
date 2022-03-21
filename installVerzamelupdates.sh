#!/bin/bash
LOGFILE=$HOME/logs/installVerzamelupdates-`date +%Y-%m-%d_%Hh%Mm`.log
mkdir ~/logs

sudo apt autoclean -y
sudo apt autoremove -y

printf "\n** 20210904 Bijwerken Python, Circuitpython, instalaltie Micropython\n**"  2>&1 | tee -a $LOGFILE
sudo apt update -y
mkdir ~/Downloads
cd ~/Downloads
git clone https://github.com/pappavis/thescript  2>&1 | tee -a $LOGFILE
cd ~/Downloads/thescript
git pull
printf "\nInstalleren VirtualHere.com USB via WiFi.\n"  2>&1 | tee -a $LOGFILE
printf "\nCircuitPython wordt bijgewerkt\n"  2>&1 | tee -a $LOGFILE
bash ./installPythonCircuitpython.sh  2>&1 | tee -a $LOGFILE
printf "\nPython wordt bijgewerkt\n"  2>&1 | tee -a $LOGFILE
bash ./installPythonVirtualenv.sh  2>&1 | tee -a $LOGFILE
bash ./installPythonLibs.sh  2>&1 | tee -a $LOGFILE
bash ./installMicropython.sh  2>&1 | tee -a $LOGFILE
#bash ./installNFSserver.sh  2>&1 | tee -a $LOGFILE

printf "\Micropython wordt geïnstalleerd\n"  2>&1 | tee -a $LOGFILE
bash ./installPHPliteadmin.sh  2>&1 | tee -a $LOGFILE
bash ./installOwncloud.sh  2>&1 | tee -a $LOGFILE
bash ./installIOT.sh  2>&1 | tee -a $LOGFILE
bash ./installUpdates.sh  2>&1 | tee -a $LOGFILE
sudo apt autoclean -y  2>&1 | tee -a $LOGFILE
sudo apt autoremove -y  2>&1 | tee -a $LOGFILE
bash ./installOctoprint.sh  2>&1 | tee -a $LOGFILE
bash ./installOctoprintWebcam.sh  2>&1 | tee -a $LOGFILE
bash ./installHomeassistant.sh  2>&1 | tee -a $LOGFILE
bash ./installHomebridgeApple.sh  2>&1 | tee -a $LOGFILE
bash ./installNodered.sh  2>&1 | tee -a $LOGFILE
printf "\nTesseract OCR wordt bijgewerkt\n"  2>&1 | tee -a $LOGFILE
bash ./installTessarectOCR.sh 2>&1 | tee -a $LOGFILE &
bash ./installExtras.sh  2>&1 | tee -a $LOGFILE
bash ./installDesktop.sh 2>&1 | tee -a $LOGFILE
sudo apt autoclean -y  2>&1 | tee -a $LOGFILE
sudo apt autoremove -y  2>&1 | tee -a $LOGFILE

printf "Let op!!  Apple Homebridge & Homeassistantop Pi 3 model A installeren, dan swapfile uitbreiden naar 1Gb!!\n"  2>&1 | tee -a $LOGFILE
printf "\nEINDE installVerzamelupdates.sh afgerond.\n"  2>&1 | tee -a $LOGFILE
