#!/bin/bash
LOGFILE=$HOME/logs/installMicropython-`date +%Y-%m-%d_%Hh%Mm`.log

echo "Start Micropython installatie"  2>&1 | tee -a $LOGFILE
# origineel --> https://www.raspberrypi.org/forums/viewtopic.php?t=191744
for addonnodes in git autoconf build-essential gperf bison flex texinfo libtool libncurses5-dev wget gawk libc6-dev-amd64 python-serial libexpat-dev ; do
  echo " "
  echo " "
  echo "Installeren micropython benodigheden: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

MPDLDIR=~/Downloads/micropython

mkdir $MPDLDIR
cd $MPDLDIR
mkdir modules
mkdir ./sqlite
git clone https://github.com/micropython/micropython.git 2>&1 | tee -a $LOGFILE
cd ./modules
git clone https://github.com/spatialdude/usqlite.git 2>&1 | tee -a $LOGFILE
git pull
cd $MPDLDIR
git pull
cd ./mpy-cross
make 2>&1 | tee -a $LOGFILE

cd  $MPDLDIR/micropython/ports/unix/
make submodules 2>&1 | tee -a $LOGFILE
make clean 2>&1 | tee -a $LOGFILE
make axtls 2>&1 | tee -a $LOGFILE
make USER_C_MODULES=$MPDLDIR/modules 2>&1 | tee -a $LOGFILE
#make   2>&1 | tee -a $LOGFILE
#sudo ln -s $MPDLDIR/ports/unix/micropython /usr/local/bin/micropython
sudo rm /usr/local/bin/micropython
sudo cp -v $MPDLDIR/micropython/ports/unix/micropython /usr/local/bin/micropython 2>&1 | tee -a $LOGFILE

echo "START micropython module intstall" 2>&1 | tee -a $LOGFILE
for addonnodes in micropython-urequests micropython-socket micropython-machine micropython-os.path micropython-umqtt.robust micropython-pwd micropython-smtplib ; do
  echo " "
  echo " "
  echo "Installeren micropython bibliotheek: ${addonnodes}"
  echo " "
  micropython -m upip install ${addonnodes} 2>&1 | tee -a $LOGFILE
done

cd $MPDLDIR/micropython/ports/windows
make submodules 2>&1 | tee -a $LOGFILE
make CROSS_COMPILE=i686-w64-mingw32- 2>&1 | tee -a $LOGFILE
cp -v ./micropython.exe ~/Downloads 2>&1 | tee -a $LOGFILE

cd $MPDLDIR/micropython/ports/esp32
make submodules 2>&1 | tee -a $LOGFILE
make 2>&1 | tee -a $LOGFILE
make erase 2>&1 | tee -a $LOGFILE
make deploy 2>&1 | tee -a $LOGFILE

cd $MPDLDIR/micropython/ports/esp8266
make submodules 2>&1 | tee -a $LOGFILE
make 2>&1 | tee -a $LOGFILE
make erase 2>&1 | tee -a $LOGFILE
make deploy 2>&1 | tee -a $LOGFILE

cd $MPDLDIR/micropython/ports/rp2
make submodules 2>&1 | tee -a $LOGFILE
make USER_C_MODULES=$MPDLDIR/ports/pico/modules/micropython.cmake  2>&1 | tee -a $LOGFILE

cd $MPDLDIR/micropython/ports/javascript
make submodules 2>&1 | tee -a $LOGFILE
make 2>&1 | tee -a $LOGFILE
make test 2>&1 | tee -a $LOGFILE
cp ./micropython.js ~/Downloads

#rm -rf ~/Downloads/modules 2>&1 | tee -a $LOGFILE
#rm -rf ~/Downloads/sqlite 2>&1 | tee -a $LOGFILE
#rm -rf $MPDLDIR 2>&1 | tee -a $LOGFILE

echo "" 2>&1 | tee -a $LOGFILE
echo "EINDE micropython $(micropython -V) module install" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
