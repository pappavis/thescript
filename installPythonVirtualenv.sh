#/usr/bin/sh
LOGFILE=$HOME/logs/installPythonVirtualenv-`date +%Y-%m-%d_%Hh%Mm`.log
echo "Installeer nieuwe python3 virtuale omgeving"
sudo usermod -aG gpio pi &
sudo usermod -aG dialout pi  &
sudo usermod -aG i2c pi &
sudo usermod -aG tty pi &
mkdir $HOME/logs/

sudo apt install -y python3-pip python3-venv  2>&1 | tee -a $LOGFILE
python3 -m pip install --user pipx pipenv  2>&1 | tee -a $LOGFILE
python3 -m pipx ensurepath  2>&1 | tee -a $LOGFILE
echo "source ~/.bashrc" >> ~/.bash_profile

#python3 -m pip install virtualenv
mkdir ~/venv
~/.local/bin/pipx install ~/venv/virtualenv  2>&1 | tee -a $LOGFILE
~/.local/bin/virtualenv ~/venv/venv3.7  2>&1 | tee -a $LOGFILE
source ~/venv/venv3.7/bin/activate  2>&1 | tee -a $LOGFILE
pip install --upgrade adafruit-blinka RPI.GPIO  2>&1 | tee -a $LOGFILE
echo "source ~/venv/venv3.7/bin/activate" >> ~/.bashrc
source ~/.bashrc  2>&1 | tee -a $LOGFILE

bash ./installPythonLibs.sh  2>&1 | tee -a $LOGFILE
