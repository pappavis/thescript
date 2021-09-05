printf "\n** 20210904 Bijwerken Python, Circuitpython, instalaltie Micropython\n**"
cd ~/Downloads/thescript
printf "\nTesseract OCR wordt bijgewerkt\n"
bash ./installTessarectOCT.sh
printf "\nCircuitPython wordt bijgewerkt\n"
bash ./installPythonCircuitpython.sh
printf "\nPython wordt bijgewerkt\n"
bash ./installPythonVirtualenv.sh
printf "\nPython wordt bijgewerkt\n"
bash ./installMicropython.sh

printf "Let op!!  Apple Homebridge & Homeassistant niet op Pi 3 model A  installeren, hij heeft te weinig geheugen!!\n"
printf "\nEINDE installVerzamelupdates.sh afgerond.\n"
