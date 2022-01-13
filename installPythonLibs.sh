#!/bin/bash
echo '** Installeer pythonlibs. je moet eerst een virtualenv activeer!!' 
LOGFILE=$HOME/logs/installPythonLibs-`date +%Y-%m-%d_%Hh%Mm`.log
_pwd=$(pwd)
mkdir $HOME/logs

#Array to store possible locations for temp read.
aFP_TEMPERATURE=(
    '/sys/class/thermal/thermal_zone0/temp'
    '/sys/devices/virtual/thermal/thermal_zone1/temp'
    '/sys/devices/platform/sunxi-i2c.0/i2c-0/0-0034/temp1_input'
    '/sys/class/hwmon/hwmon0/device/temp_label'
)

Obtain_Cpu_Temp(){
    for ((i=0; i<${#aFP_TEMPERATURE[@]}; i++))
    do
        if [ -f "${aFP_TEMPERATURE[$i]}" ]; then
            CPU_TEMP_CURRENT=$(cat "${aFP_TEMPERATURE[$i]}")
            # - Some devices (pine) provide 2 digit output, some provide a 5 digit ouput.
            #       So, If the value is over 1000, we can assume it needs converting to 1'c
            if (( $CPU_TEMP_CURRENT == 0 )); then
                continue
            fi
            if (( $CPU_TEMP_CURRENT >= 1000 )); then
                CPU_TEMP_CURRENT=$( echo -e "$CPU_TEMP_CURRENT" | awk '{print $1/1000}' | xargs printf "%0.0f" )
            fi
            if (( $CPU_TEMP_CURRENT >= 70 )); then
                CPU_TEMP_PRINT="\e[91mWarning: $CPU_TEMP_CURRENT'c\e[0m"
                elif (( $CPU_TEMP_CURRENT >= 60 )); then
                CPU_TEMP_PRINT="\e[38;5;202m$CPU_TEMP_CURRENT'c\e[0m"
                elif (( $CPU_TEMP_CURRENT >= 50 )); then
                CPU_TEMP_PRINT="\e[93m$CPU_TEMP_CURRENT'c\e[0m"
                elif (( $CPU_TEMP_CURRENT >= 40 )); then
                CPU_TEMP_PRINT="\e[92m$CPU_TEMP_CURRENT'c\e[0m"
                elif (( $CPU_TEMP_CURRENT >= 30 )); then
                CPU_TEMP_PRINT="\e[96m$CPU_TEMP_CURRENT'c\e[0m"
            else
                CPU_TEMP_PRINT="\e[96m$CPU_TEMP_CURRENT'c\e[0m"
            fi
            break
        fi
    done
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


python3 -m ensurepip 2>&1 | tee -a $LOGFILE
python3 -m pip install virtualenv 2>&1 | tee -a $LOGFILE
~/.local/bin/virtualenv ~/venv/venv3.7/
source ~/venv/venv3.7/bin/activate

sudo apt install -y unixodbc-dev 2>&1 | tee -a $LOGFILE

for addonnodes in  unixodbc-dev wiringpi i2c-tools; do
    printstatus "Installeren: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
done

python -m ensurepip  2>&1 | tee -a $LOGFILE

for addonnodes in  libatlas-base-dev libwebp-dev  python3-opencv  ; do
    printstatus "Installeren OpenCV vereisten: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    sudo apt install $NQUIET -y ${addonnodes} 2>&1 | tee -a $LOGFILE
  done

for addonnodes in pip setuptools wheel openpyxl o365 ttn qrcode pillow sqlalchemy pymsteams esptool adafruit-ampy firebirdsql \
                  pyserial pyparsing pyzmail gpiozero pytube pipx serial jinja2 esptool mpfshell virtualenv ffmpeg conda \
                  scikit-build pygame pymongo psycopg2-binary mysql-connector-python guizero skimage imutils scikit-image \
                  msteamsconnector matplotlib numpy imutils pyodbc pysmb  opencv-contrib-python git+https://github.com/pytube/pytube picamera djitellopy \
		   osxphotos RPi.GPIO  ; do
    printstatus "Installeren python lib: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
  done

echo "doen ook --> pip uninstall serial" 2>&1 | tee -a $LOGFILE

printstatus  "Installeer Dataplicity.com" 2>&1 | tee -a $LOGFILE
curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python 2>&1 | tee -a $LOGFILE

cd $_pwd

pip install --upgrade RPi.GPIO  2>&1 | tee -a $LOGFILE &
pip uninstall --no-input serial  2>&1 | tee -a $LOGFILE

printstatus "installPythonLibs.sh is afgerond"  2>&1 | tee -a $LOGFILE
