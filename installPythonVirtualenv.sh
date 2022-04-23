#/usr/bin/sh
LOGFILE=$HOME/logs/installPythonVirtualenv-`date +%Y-%m-%d_%Hh%Mm`.log
echo "Installeer nieuwe python3 virtuale omgeving" 2>&1 | tee -a $LOGFILE
sudo usermod -aG gpio pi &
sudo usermod -aG dialout pi  &
sudo usermod -aG i2c pi &
sudo usermod -aG tty pi &
mkdir $HOME/logs/

echo ""  2>&1 | tee -a $LOGFILE
echo "Uitvoeren installPythonVirtualenv.sh begint."  2>&1 | tee -a $LOGFILE
echo ""  2>&1 | tee -a $LOGFILE

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
for addonnodes in  virtualenv python3-virtualenv python3-pip  ; do 
	echo  "Installing python virtualenv  \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done
/usr/bin/python3  -m pip install virtualenv 2>&1 | tee -a $LOGFILE
/usr/bin/python3  -m virtualenv -p /usr/bin/python3 ~/venv/venv 2>&1 | tee -a $LOGFILE
#/usr/python/python3.11 -m pip install virtualenv 2>&1 | tee -a $LOGFILE
#~/.local/bin/virtualenv3.11 ~/venv/venv3.11
echo "source ~/venv/$VENV/bin/activate" >> ~/.bashrc
source ~/.bashrc
echo "Virtualenv versie: $(python -V)" 2>&1 | tee -a $LOGFILE
echo "PATH=$PATH:~/.local/bin" >> ~/.bashrc
source ~/.bashrc  2>&1 | tee -a $LOGFILE

echo "" 2>&1 | tee -a $LOGFILE
echo "InstallPythonVirtualenv afgerond." 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

bash ./installPythonLibs.sh  2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
