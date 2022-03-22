#/usr/bin/sh
LOGFILE=$HOME/logs/installPythonVirtualenv-`date +%Y-%m-%d_%Hh%Mm`.log
echo "Installeer nieuwe python3 virtuale omgeving"
sudo usermod -aG gpio pi &
sudo usermod -aG dialout pi  &
sudo usermod -aG i2c pi &
sudo usermod -aG tty pi &
mkdir $HOME/logs/

for addonnodes in  unixodbc-dev wiringpi python3-opencv ; do
    echo "Installeren: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    sudo apt install -y ${addonnodes}  2>&1 | tee -a $LOGFILE
done


for addonnodes in pipx pipenv wheel ; do
    echo "Installeren: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install --user --upgrade ${addonnodes}  2>&1 | tee -a $LOGFILE
done

python3 -m pipx ensurepath  2>&1 | tee -a $LOGFILE
echo "source ~/.bashrc" >> ~/.bash_profile

#python3 -m pip install virtualenv
mkdir ~/venv
~/.local/bin/pipx install ~/venv/virtualenv  2>&1 | tee -a $LOGFILE
python3 -m pip install --upgrade virtualenv 
python3 -m virtualenv ~/venv/venv  2>&1 | tee -a $LOGFILE
source ~/venv/venv/bin/activate  2>&1 | tee -a $LOGFILE
for addonnodes in adafruit-blinka RPI.GPIO  ; do
    echo "Installeren: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install --user --upgrade ${addonnodes}  2>&1 | tee -a $LOGFILE
done
echo "source ~/venv/venv/bin/activate" >> ~/.bashrc
source ~/.bashrc  2>&1 | tee -a $LOGFILE

bash ./installPythonLibs.sh  2>&1 | tee -a $LOGFILE
