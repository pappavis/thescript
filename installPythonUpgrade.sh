LOGFILE=$HOME/$0-`date +%Y-%m-%d_%Hh%Mm`.log

printf "** Python upgrade installeren\n"
sudo apt install -y libffi-dev libbz2-dev liblzma-dev libsqlite3-dev 
sudo apt install -y libncurses5-dev libgdbm-dev zlib1g-dev libreadline-dev libssl-dev tk-dev build-essential
sudo apt install -y libncursesw5-dev libc6-dev openssl git
cd ~/Downloads
wget https://github.com/python/cpython/archive/refs/tags/v3.11.0a1.zip
7z x v3.11.0a1.zip
cd cpython-3.11.0a1/
./configure --prefix=$HOME/.local --enable-optimizations
make -j -l 4
make install
~/.local/bin/python3.11 -m pip install --upgrade virtualenv
mkdir ~/venv
~/.local/bin/python3.11 -m virtualenv ~/venv/venv3.11
echo "source ~/venv/venv3.11/bin/activate" >> ~/.bashrc
source ~/venv/venv3.11/bin/activate
source ~/.bashrc
bash ./installPythonLibs.sh
bash ./installPythonCircuitpython.sh

pythonV=$(python -V)
printf "* $pythonV upgrade afgerond\n"
