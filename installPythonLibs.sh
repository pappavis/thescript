echo '** Installeer pythonlibs. je moet eerst een virtualenv activeer!!' 
LOGFILE=$HOME/$0-`date +%Y-%m-%d_%Hh%Mm`.log


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


python3 -m ensurepip
python3 -m pip install virtualenv
~/.local/bin/virtualenv ~/venv/venv3.7/
source ~/venv/venv3.7/bin/activate

sudo apt install -y wiringpi 
sudo apt install -y rpi.gpio

python -m ensurepip 

for addonnodes in openpyxl o365 ttn qrcode pillow sqlalchemy pymsteams esptool adafruit-ampy firebirdsql \
                  pyserial pyparsing pyzmail gpiozero pytube pipx serial jinja2 esptool mpfshell virtualenv ffmpeg \
                  scikit-build pygame pymongo psycopg2-binary mysql-connector-python guizero \
                  scikit-build pygame pymongo psycopg2-binary mysql-connector-python guizero ;
  do
    printstatus "Installeren python lib \"${addonnodes}\""
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
  done

##pip install --upgrade openpyxl o365 ttn qrcode pillow sqlalchemy pymsteams esptool adafruit-ampy firebirdsql 
##pip install --upgrade pyserial pyparsing pyzmail gpiozero pytube 
##pip install --upgrade pipx serial jinja2 esptool mpfshell virtualenv ffmpeg
##pip install --upgrade scikit-build pygame pymongo psycopg2-binary mysql-connector-python guizero
##pip install --upgrade rpi.gpio
##pip install --upgrade matplotlib numpy imutils
##python3 -m pip install git+https://github.com/pytube/pytube
echo "doen ook --> pip uninstall serial"

pip install --upgrade pyodbc
curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python
pip install --upgrade pip setuptools wheel
sudo apt install -y python3-opencv

echo "pip install opencv-python-headless==4.4.0.44"
echo "pip install --upgrade djitellopy"
ehco "pip install --upgrade osxphotos"
