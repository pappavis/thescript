LOGFILE=$HOME/logs/installMicropython-`date +%Y-%m-%d_%Hh%Mm`.log

echo "Start Micropython installatie"  2>&1 | tee -a $LOGFILE
# origineel --> https://www.raspberrypi.org/forums/viewtopic.php?t=191744
for addonnodes in git build-essential libffi-dev ; do
  echo " "
  echo " "
  echo "Installeren micropython benodigheden: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

cd ~/Downloads
mkdir modules
mkdir sqlite
git clone https://github.com/micropython/micropython.git 2>&1 | tee -a $LOGFILE
cd modules
git clone https://github.com/spatialdude/usqlite.git 2>&1 | tee -a $LOGFILE
cd ~/Downloads && cd micropython/mpy-cross
make 2>&1 | tee -a $LOGFILE
cd ~/micropython/ports/unix/
make clean 2>&1 | tee -a $LOGFILE
make axtls 2>&1 | tee -a $LOGFILE
make 2>&1 | tee -a $LOGFILE
sudo ln -s ~/micropython/ports/unix/micropython /usr/local/bin/micropython
echo "START micropython module intstall" 2>&1 | tee -a $LOGFILE
micropython  -m upip install micropython-urequests 2>&1 | tee -a $LOGFILE
micropython  -m upip install micropython-socket 2>&1 | tee -a $LOGFILE
micropython  -m upip install micropython-machine 2>&1 | tee -a $LOGFILE
micropython  -m upip install micropython-os.path 2>&1 | tee -a $LOGFILE
micropython  -m upip install micropython-umqtt.robust 2>&1 | tee -a $LOGFILE
micropython  -m upip install micropython-pwd 2>&1 | tee -a $LOGFIL 2>&1 | tee -a $LOGFILEE
micropython  -m upip install micropython-smtplib
cd  ~/Downloads/micropython/ports/esp32/
make clean 2>&1 | tee -a $LOGFILE
make axtls 2>&1 | tee -a $LOGFILE
make 2>&1 | tee -a $LOGFILE
cd  ~/Downloads/micropython/ports/esp8266/
make clean 2>&1 | tee -a $LOGFILE
make axtls 2>&1 | tee -a $LOGFILE
make 2>&1 | tee -a $LOGFILE

echo "EINDE micropython $(micropython -V) module install" 2>&1 | tee -a $LOGFILE

