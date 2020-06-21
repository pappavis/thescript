sudo apt-get install - y git build-essential libffi-dev
cd ~
git clone https://github.com/micropython/micropython.git
cd ~ && cd micropython/mpy-cross
make
cd ~/micropython/ports/unix/
make clean
make
./micropython
