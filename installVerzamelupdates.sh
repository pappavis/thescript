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

printf "\ninstallVerzamelupdates.sh afgerond.\n"
