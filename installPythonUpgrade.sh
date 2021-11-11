LOGFILE=/home/pi/PythonUpgradefile-`date +%Y-%m-%d_%Hh%Mm`.log

echo "** Python upgrade installeren\n"
sudo apt install -y libffi-dev libbz2-dev liblzma-dev libsqlite3-dev  2>&1 | tee -a $LOGFILE
sudo apt install -y libncurses5-dev libgdbm-dev zlib1g-dev libreadline-dev libssl-dev tk-dev build-essential 2>&1 | tee -a $LOGFILE
sudo apt install -y libncursesw5-dev libc6-dev openssl git 2>&1 | tee -a $LOGFILE
cd ~/Downloads
wget https://github.com/python/cpython/archive/refs/tags/v3.11.0a1.zip 2>&1 | tee -a $LOGFILE
7z x v3.11.0a1.zip 2>&1 | tee -a $LOGFILE
cd cpython-3.11.0a1/
./configure --prefix=$HOME/.local --enable-optimizations 2>&1 | tee -a $LOGFILE
make -j -l 4
make install
~/.local/bin/python3.11 -m pip install --upgrade virtualenv 2>&1 | tee -a $LOGFILE
mkdir ~/venv
~/.local/bin/python3.11 -m virtualenv ~/venv/venv3.11 2>&1 | tee -a $LOGFILE
echo "source ~/venv/venv3.11/bin/activate" >> ~/.bashrc 2>&1 | tee -a $LOGFILE
source ~/venv/venv3.11/bin/activate
bash ./installPythonLibs.sh 2>&1 | tee -a $LOGFILE
bash ./installPythonCircuitpython.sh 2>&1 | tee -a $LOGFILE

pythonV=$(python -V)
ehco "* $pythonV upgrade afgerond\n" 2>&1 | tee -a $LOGFILE
