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
VENV="venv"
rm -rf ~/venv/$VENV
mkdir ~/venv
for addonnodes in  virtualenv python3-virtualenv  ; do 
	echo  "Installing python virtualenv  \"${addonnodes}\""
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done
python3 -m pip install virtualenv 2>&1 | tee -a $LOGFILE
virtualenv -p /usr/bin/python3  virtualenv
#/usr/python/python3.11 -m pip install virtualenv 2>&1 | tee -a $LOGFILE
#~/.local/bin/virtualenv3.11 ~/venv/venv3.11
echo "source ~/venv/$VENV/bin/activate" >> ~/.bashrc
source ~/.bashrc
echo "Virtualenv versie: $(python -V)" 2>&1 | tee -a $LOGFILE
echo "PATH=$PATH:~/.local/bin" >> ~/.bashrc
source ~/.bashrc  2>&1 | tee -a $LOGFILE

bash ./installPythonLibs.sh  2>&1 | tee -a $LOGFILE
