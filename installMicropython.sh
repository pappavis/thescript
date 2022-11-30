#!/bin/bash
LOGFILE=$HOME/logs/installMicropython-`date +%Y-%m-%d_%Hh%Mm`.log

echo "Start Micropython installatie"  2>&1 | tee -a $LOGFILE
# origineel --> https://www.raspberrypi.org/forums/viewtopic.php?t=191744
for addonnodes in git autoconf build-essential gperf bison flex texinfo libtool libncurses5-dev wget gawk libc6-dev-amd64 python-serial libexpat-dev gcc-mingw-w64 ; do
  echo " "
  echo " "
  echo "Installeren micropython benodigheden: ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

MPDLDIR=~/Downloads/micropython
cd ~/Downloads
git clone https://github.com/micropython/micropython.git 2>&1 | tee -a $LOGFILE

cd $MPDLDIR/mpy-cross
make  2>&1 | tee -a $LOGFILE
# sqlite voor Micropython
mkdir ~/Downloads/modules
mkdir ~/Downloads/sqlite
cd ~/Downloads/modules
git clone https://github.com/spatialdude/usqlite.git 2>&1 | tee -a $LOGFILE


# basis Micropython voor UN*X
cd $MPDLDIR/ports/unix/
make submodules 2>&1 | tee -a $LOGFILE
make clean 2>&1 | tee -a $LOGFILE
make USER_C_MODULES=~/Downloads/modules 2>&1 | tee -a $LOGFILE
make test 2>&1 | tee -a $LOGFILE
#make axtls 2>&1 | tee -a $LOGFILE
#make deplibs 2>&1 | tee -a $LOGFILE
mkdir /usr/local/bin
sudo rm /usr/local/bin/micropython
sudo cp -v ./build-standard/micropython /usr/local/bin 2>&1 | tee -a $LOGFILE
micropython -m mip install hmac 2>&1 | tee -a $LOGFILE

#sudo ln -s $MPDLDIR/ports/unix/micropython /usr/local/bin/micropython

micropython -m upip install micropython-pystone 2>&1 | tee -a $LOGFILE
micropython -m mip install micropython-pystone 2>&1 | tee -a $LOGFILE
micropython -m pystone 2>&1 | tee -a $LOGFILE
echo "micropython UNIX versie compile afgerond" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

echo "START micropython module install" 2>&1 | tee -a $LOGFILE
for addonnodes in micropython-urequests micropython-socket micropython-machine micropython-os.path micropython-umqtt.robust micropython-pwd micropython-smtplib urequests  micropython-urequests  micropython-mqtt ; do
  echo " "
  echo " "
  echo "Installeren micropython bibliotheek: ${addonnodes}" 2>&1 | tee -a $LOGFILE
  echo " "
  micropython -m upip install ${addonnodes} 2>&1 | tee -a $LOGFILE
done

echo "Micropython bouwen port: windows" 2>&1 | tee -a $LOGFILE
cd $MPDLDIR/ports/windows
make submodules 2>&1 | tee -a $LOGFILE
make CROSS_COMPILE=i686-w64-mingw32- 2>&1 | tee -a $LOGFILE
cp -v ./build-standard/micropython.exe ~/Downloads 2>&1 | tee -a $LOGFILE

echo "Micropython bouwen port: esp32" 2>&1 | tee -a $LOGFILE
sudo apt install -y picocom
cd $MPDLDIR/ports/esp32
make submodules 2>&1 | tee -a $LOGFILE
make 2>&1 | tee -a $LOGFILE
make erase 2>&1 | tee -a $LOGFILE
make deploy 2>&1 | tee -a $LOGFILE
make test 2>&1 | tee -a $LOGFILE
echo "micropython esp32 versie compile afgerond" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

echo "Micropython bouwen port: esp8266" 2>&1 | tee -a $LOGFILE
cd $MPDLDIR/ports/esp8266
make submodules 2>&1 | tee -a $LOGFILE
cd ./modules 
git clone https://github.com/spatialdude/usqlite.git 2>&1 | tee -a $LOGFILE
cd $MPDLDIR/ports/esp8266
make 2>&1 | tee -a $LOGFILE
make erase 2>&1 | tee -a $LOGFILE
make deploy 2>&1 | tee -a $LOGFILE
echo "micropython esp8266 versie compile afgerond" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

echo "Micropython bouwen port: esp32" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
git clone -b v4.0.2 --recursive https://github.com/espressif/esp-idf.git
cd ~/Downloads/esp-idf
git checkout v4.2
git submodule update --init --recursive
bash ./install.sh
source ./export.sh
cd $MPDLDIR/ports/esp32
make submodules 2>&1 | tee -a $LOGFILE
make clean
make USER_C_MODULES=~/Downloads/modules/
make 2>&1 | tee -a $LOGFILE
make erase 2>&1 | tee -a $LOGFILE
make deploy 2>&1 | tee -a $LOGFILE
echo "micropython esp32 versie compile afgerond" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE


echo "Micropython bouwen port: stm32" 2>&1 | tee -a $LOGFILE
cd $MPDLDIR/ports/stm32
make submodules 2>&1 | tee -a $LOGFILE
make deploy 2>&1 | tee -a $LOGFILE
make  2>&1 | tee -a $LOGFILE
echo "micropython stm32 versie compile afgerond" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

echo "Micropython bouwen port: qemu-arm" 2>&1 | tee -a $LOGFILE
cd $MPDLDIR/ports/qemu-arm
make submodules 2>&1 | tee -a $LOGFILE
make -f Makefile.test test 2>&1 | tee -a $LOGFILE
make erase 2>&1 | tee -a $LOGFILE
make deploy 2>&1 | tee -a $LOGFILE
echo "micropython qemu-arm versie compile afgerond" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

echo "Micropython bouwen port: rp2" 2>&1 | tee -a $LOGFILE
cd $MPDLDIR/ports/rp2
make submodules 2>&1 | tee -a $LOGFILE
make clean  2>&1 | tee -a $LOGFILE
make  2>&1 | tee -a $LOGFILE
#make USER_C_MODULES=$MPDLDIR/ports/pico/modules/micropython.cmake  2>&1 | tee -a $LOGFILE
echo "micropython rp2 versie compile afgerond" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

echo "Micropython bouwen port: Javascript" 2>&1 | tee -a $LOGFILE
cd $MPDLDIR/ports/javascript
make submodules 2>&1 | tee -a $LOGFILE
make 2>&1 | tee -a $LOGFILE
make test 2>&1 | tee -a $LOGFILE
cp ./micropython.js ~/Downloads
echo "micropython javascript versie compile afgerond" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

mkdir ~/.node-red 2>&1 | tee -a $LOGFILE
cd ~/.node-red
npm install --save micropython 2>&1 | tee -a $LOGFILE
sudo mkdir /var/www/html/apps
sudo mkdir /var/www/html/static
sudo mkdir /var/www/html/static/js
sudo cp -v ./node_modules/micropython/lib/firmware.wasm /var/www/html/static/js 2>&1 | tee -a $LOGFILE
sudo cp -v ~/Downloads/thescript/demo/micropython_in_browser.php /var/www/html/apps 2>&1 | tee -a $LOGFILE
sudo chown www-data:www-data -R /var/www/html/ 2>&1 | tee -a $LOGFILE

#rm -rf ~/Downloads/modules 2>&1 | tee -a $LOGFILE
#rm -rf ~/Downloads/sqlite 2>&1 | tee -a $LOGFILE
#rm -rf $MPDLDIR 2>&1 | tee -a $LOGFILE

rm -rf $MPDLDIR 2>&1 | tee -a $LOGFILE

echo "" 2>&1 | tee -a $LOGFILE
echo "Installeer extra bibliotheken" 2>&1 | tee -a $LOGFILE
mkdir ~/Downloads/micropython_libs
mkdir ~/.micropython
mkdir ~/.micropython/lib
cd ~/Downloads/micropython_libs
git clone https://github.com/jplattel/upymenu
cp -r -v ./upymenu/upymenu ~/.micropython/lib 2>&1 | tee -a $LOGFILE

cd ~/.micropython/lib
echo "" 2>&1 | tee -a $LOGFILE

git clone https://github.com/jordiprats/micropython-utelegram 2>&1 | tee -a $LOGFILE
cp -r -v ./micropython-utelegram/utelegram.py  ~/.micropython/lib 2>&1 | tee -a $LOGFILE

git clone https://github.com/gabrielebarola/telegram-upy.git
cp -r -v ./telegram-upy/utelegram.py  ~/.micropython/lib 2>&1 | tee -a $LOGFILE

git clone https://github.com/Carglglz/upyble 2>&1 | tee -a $LOGFILE

git clone https://github.com/robert-hh/FTP-Server-for-ESP8266-ESP32-and-PYBD
cp -r -v ./FTP-Server-for-ESP8266-ESP32-and-PYBD/uftp.py  ~/.micropython/lib 2>&1 | tee -a $LOGFILE

git clone https://github.com/chrismoorhouse/micropython-mqtt
cp -r -v ./micropython-mqtt  ~/.micropython/lib 2>&1 | tee -a $LOGFILE

echo "" 2>&1 | tee -a $LOGFILE
echo "EINDE micropython $(micropython -V) module install $(date)" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
