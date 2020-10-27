# origineel --> https://www.raspberrypi.org/forums/viewtopic.php?t=191744
sudo apt-get install -y git build-essential libffi-dev
cd ~
git clone https://github.com/micropython/micropython.git
cd ~ && cd micropython/mpy-cross
make
cd ~/micropython/ports/unix/
make clean
make axtls
make
sudo ln -s ~/micropython/ports/unix/micropython /usr/local/bin/micropython
echo "START module intstall"
micropython  -m upip install micropython-urequests
micropython  -m upip install micropython-socket
micropython  -m upip install micropython-machine
micropython  -m upip install micropython-os.path
micropython  -m upip install micropython-umqtt.robust
micropython  -m upip install micropython-pwd
micropython  -m upip install micropython-smtplib
echo "EINDE micropython module intstall"

