#/usr/bin/sh
LOGFILE=$HOME/logs/installPythonVirtualenv-`date +%Y-%m-%d_%Hh%Mm`.log
echo "Installeer nieuwe python3 virtuale omgeving" 2>&1 | tee -a $LOGFILE

for addonnodes in dialout tty gpio i2c docker ; do
  echo "Gebruiker $gebr rechten toewijzen aan groep:  \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
  sudo usermod $gebr -g ${addonnodes}  2>&1 | tee -a $LOGFILE
done

mkdir $HOME/logs/

usermod 
echo ""  2>&1 | tee -a $LOGFILE
echo "Uitvoeren installPythonVirtualenv.sh begint."  2>&1 | tee -a $LOGFILE
echo ""  2>&1 | tee -a $LOGFILE

#python3 -m pip install virtualenv
mkdir ~/venv
VENV="venv"
rm -rf ~/venv/$VENV
mkdir ~/venv
for addonnodes in  virtualenv python3-virtualenv python3-pip python3-wheel python3-setuptools ; do 
	echo  "Installing python virtualenv systeem benodigheden  \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done
/usr/bin/python3  -m pip install virtualenv 2>&1 | tee -a $LOGFILE
/usr/bin/python3  -m virtualenv --system-site-packages -p /usr/bin/python3 ~/venv/venv 2>&1 | tee -a $LOGFILE
#/usr/python/python3.11 -m pip install virtualenv 2>&1 | tee -a $LOGFILE
#~/.local/bin/virtualenv3.11 ~/venv/venv3.11
echo "source ~/venv/$VENV/bin/activate" >> ~/.bashrc
python3 -m pipx ensurepath  2>&1 | tee -a $LOGFILE
source ~/.bashrc
echo "Virtualenv versie: $(python -V)" 2>&1 | tee -a $LOGFILE
echo "PATH=$PATH:~/.local/bin" >> ~/.bashrc

for addonnodes in pipx pipenv wheel ; do
    echo "Installeren: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install --user --upgrade ${addonnodes}  2>&1 | tee -a $LOGFILE
done

echo "" 2>&1 | tee -a $LOGFILE
echo "InstallPythonVirtualenv afgerond." 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

bash ./installPythonLibs.sh  2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
