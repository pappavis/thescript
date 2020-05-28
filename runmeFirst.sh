
printstatus "Welkom, setup een nieuwe Raspbian of Ubunto omgeving"
LOGFILE=$HOME/$0-`date +%Y-%m-%d_%Hh%Mm`.log

printl() {
	printf $1
	echo -e $1 >> $LOGFILE
}

printstatus() {
    Obtain_Cpu_Temp
    h=$(($SECONDS/3600));
    m=$((($SECONDS/60)%60));
    s=$(($SECONDS%60));
    printf "\r\n${BIGreen}==\r\n== ${BIYellow}$1"
    printf "\r\n${BIGreen}== ${IBlue}Total: %02dh:%02dm:%02ds Cores: $ACTIVECORES Temperature: $CPU_TEMP_PRINT \r\n${BIGreen}==${IWhite}\r\n\r\n"  $h $m $s;
	echo -e "############################################################" >> $LOGFILE
	echo -e $1 >> $LOGFILE
}


AQUIET="-qq"
NQUIET="-s"
export npm_config_loglevel=silent


sudo apt-get update -y && sudo apt-get upgrade
sudo apt-get install -y p7zip-full mc  sqlite3
sudo apt-get install -y gedit vsftpd 
sudo apt-get install -y apache2 php php-mysql
sudo apt-get install -y nodejs npm  wolfram-engine

echo  alias ls="ls -F --color=auto" >> ~/.profile
echo  alias l="ls -F --color=auto" >> ~/.profile
echo  alias ll="ls -lF --color=auto" >> ~/.profile
echo  alias la="ls -lFa --color=auto" >> ~/.profile
echo   ~/venv/venv3.7/bin/activate >> ~/.profile

python3 -m pip install --user pipx
python3 -m pipx ensurepath
mkdir ~/venv
source ~/.bashrc

pipx install virtualenv
mkdir ~/venv
virtualenv ~/venv/venv3.7

echo "doen usermod"
sudo usermod -aG gpio pi
sudo usermod -aG dialout pi
sudo usermod -aG i2c pi
sudo usermod -aG tty pi

sudo adduser michiele
sudo usermod -aG sudo michiele
sudo usermod -aG gpio michiele
sudo usermod -aG dialout michiele
sudo usermod -aG i2c michiele
sudo usermod -aG spi michiele
sudo usermod -aG tty michiele

#bash ./setupNodered.sh
