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

# https://github.com/esp8266/esp8266-wiki/wiki/Toolchain#install-the-xtensa-crosstool-ng-as-local-user
mkdir /opt/Espressif
sudo chown $username /opt/Espressif/ 2>&1 | tee -a $LOGFILE
cd /opt/Espressif
git clone -b lx106 git://github.com/jcmvbkbc/crosstool-NG.git  2>&1 | tee -a $LOGFILE
cd crosstool-NG
./bootstrap  2>&1 | tee -a $LOGFILE && ./configure --prefix=`pwd` 2>&1 | tee -a $LOGFILE && make && make install 2>&1 | tee -a $LOGFILE
./ct-ng xtensa-lx106-elf 2>&1 | tee -a $LOGFILE
./ct-ng build 2>&1 | tee -a $LOGFILE
PATH=$PWD/builds/xtensa-lx106-elf/bin:$PATH

cd /opt/Espressif
wget -O esp_iot_sdk_v0.9.3_14_11_21.zip https://github.com/esp8266/esp8266-wiki/raw/master/sdk/esp_iot_sdk_v0.9.3_14_11_21.zip
wget -O esp_iot_sdk_v0.9.3_14_11_21_patch1.zip https://github.com/esp8266/esp8266-wiki/raw/master/sdk/esp_iot_sdk_v0.9.3_14_11_21_patch1.zip
unzip esp_iot_sdk_v0.9.3_14_11_21.zip
unzip esp_iot_sdk_v0.9.3_14_11_21_patch1.zip
mv esp_iot_sdk_v0.9.3 ESP8266_SDK
mv License ESP8266_SDK/
cd /opt/Espressif/ESP8266_SDK
sed -i -e 's/xt-ar/xtensa-lx106-elf-ar/' -e 's/xt-xcc/xtensa-lx106-elf-gcc/' -e 's/xt-objcopy/xtensa-lx106-elf-objcopy/' Makefile
mv examples/IoT_Demo .
cd /opt/Espressif/ESP8266_SDK
wget -O lib/libc.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libc.a
wget -O lib/libhal.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libhal.a
wget -O include.tgz https://github.com/esp8266/esp8266-wiki/raw/master/include.tgz
tar -xvzf include.tgz

#Installing the ESP image tool
cd /opt/Espressif
wget -O esptool_0.0.2-1_i386.deb https://github.com/esp8266/esp8266-wiki/raw/master/deb/esptool_0.0.2-1_i386.deb
dpkg -i esptool_0.0.2-1_i386.deb

cd ~/Downloads
mkdir modules
mkdir ./sqlite
git clone https://github.com/micropython/micropython.git 2>&1 | tee -a $LOGFILE
cd ./modules
git clone https://github.com/spatialdude/usqlite.git 2>&1 | tee -a $LOGFILE
git pull
cd ~/Downloads/micropython
git pull
cd ./mpy-cross
make 2>&1 | tee -a $LOGFILE

#Blinky, A Community Example
cd /opt/Espressif
git clone https://github.com/esp8266/source-code-examples.git 2>&1 | tee -a $LOGFILE
cd source-code-examples/blinky
make 2>&1 | tee -a $LOGFILE

# The IoT Demo
cd /opt/Espressif/ESP8266_SDK/IoT_Demo
make 2>&1 | tee -a $LOGFILE

# Preparing the Firmware Image
cd .output/eagle/debug/image
esptool -eo eagle.app.v6.out -bo eagle.app.v6.flash.bin -bs .text -bs .data -bs .rodata -bc -ec
xtensa-lx106-elf-objcopy --only-section .irom0.text -O binary eagle.app.v6.out eagle.app.v6.irom0text.bin
cp eagle.app.v6.flash.bin ../../../../../bin/
cp eagle.app.v6.irom0text.bin ../../../../../bin/

cd  ~/Downloads/micropython/ports/unix/
make submodules 2>&1 | tee -a $LOGFILE
make clean 2>&1 | tee -a $LOGFILE
make axtls 2>&1 | tee -a $LOGFILE
make USER_C_MODULES=~/Downloads/modules 2>&1 | tee -a $LOGFILE
#make   2>&1 | tee -a $LOGFILE
#sudo ln -s ~/Downloads/micropython/ports/unix/micropython /usr/local/bin/micropython
sudo rm /usr/local/bin/micropython
sudo cp -v ~/Downloads/micropython/ports/unix/micropython /usr/local/bin/micropython 2>&1 | tee -a $LOGFILE

echo "START micropython module intstall" 2>&1 | tee -a $LOGFILE
for addonnodes in micropython-urequests micropython-socket micropython-machine micropython-os.path micropython-umqtt.robust micropython-pwd micropython-smtplib ; do
  echo " "
  echo " "
  echo "Installeren micropython bibliotheek: ${addonnodes}"
  echo " "
  micropython -m upip install ${addonnodes} 2>&1 | tee -a $LOGFILE
done

cd ~/Downloads/micropython/ports/windows
make submodules 2>&1 | tee -a $LOGFILE
make CROSS_COMPILE=i686-w64-mingw32- 2>&1 | tee -a $LOGFILE
cp -v ./micropython.exe ~/Downloads 2>&1 | tee -a $LOGFILE

cd ~/Downloads/micropython/ports/esp32
make submodules 2>&1 | tee -a $LOGFILE
make 2>&1 | tee -a $LOGFILE
make erase 2>&1 | tee -a $LOGFILE
make deploy 2>&1 | tee -a $LOGFILE

cd ~/Downloads/micropython/ports/esp8266
make submodules 2>&1 | tee -a $LOGFILE
make 2>&1 | tee -a $LOGFILE
make erase 2>&1 | tee -a $LOGFILE
make deploy 2>&1 | tee -a $LOGFILE

cd ~/Downloads/micropython/ports/rp2
make submodules 2>&1 | tee -a $LOGFILE
make USER_C_MODULES=~/Downloads/micropython/ports/pico/modules/micropython.cmake  2>&1 | tee -a $LOGFILE

cd ~/Downloads/micropython/ports/javascript
make submodules 2>&1 | tee -a $LOGFILE
make 2>&1 | tee -a $LOGFILE
make test 2>&1 | tee -a $LOGFILE
cp ./micropython.js ~/Downloads

#rm -rf ~/Downloads/modules 2>&1 | tee -a $LOGFILE
#rm -rf ~/Downloads/sqlite 2>&1 | tee -a $LOGFILE
#rm -rf ~/Downloads/micropython 2>&1 | tee -a $LOGFILE

echo "EINDE micropython $(micropython -V) module install" 2>&1 | tee -a $LOGFILE

