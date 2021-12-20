#/usr/bin/sh
LOGFILE=$HOME/installPythonCircuitpython-`date +%Y-%m-%d`.log

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


sudo adduser pi gpio
sudo usermod pi dialout
sudo usermod pi i2c 
sudo usermod pi tty 

echo "Installeer nieuwe python3 virtuale omgeving"
source ~/venv/venv3.7/bin/activate 
sudo apt install -y wiringpi 
sudo apt install -y rpi.gpio

python -m ensurepip 

for addonnodes in rpi.gpio adafruit-blinka adafruit-circuitpython-ble-adafruit adafruit-circuitpython-neopixel adafruit-circuitpython-ina219 adafruit-circuitpython-tinylora adafruit-circuitpython-ssd1306  DotStar_Emulator \
                  adafruit-circuitpython-miniqr adafruit-circuitpython-turtle adafruit-circuitpython-74hc595 adafruit-circuitpython-display-button adafruit-circuitpython-mpu6050 adafruit-circuitpython-ina260 adafruit-circuitpython-ssd1306 adafruit-circuitpython-ble  adafruit-circuitpython-ble-heart-rate adafruit-circuitpython-ble-broadcastnet adafruit-circuitpython-binascii  adafruit-circuitpython-onewire adafruit-circuitpython-motor  adafruit-circuitpython-hts221 adafruit-circuitpython-midi adafruit-circuitpython-bmp280  adafruit-circuitpython-bme680 adafruit-circuitpython-dotstar  adafruit-circuitpython-max7219 adafruit-circuitpython-display-text adafruit-circuitpython-rfm69 adafruit-circuitpython-dht adafruit-circuitpython-ble-apple-media adafruit-circuitpython-bme280 adafruit-circuitpython-bitbangio adafruit-circuitpython-led-animation adafruit-circuitpython-ble-midi adafruit-circuitpython-sd adafruit-circuitpython-neopixel adafruit-circuitpython-hid adafruit-circuitpython-gps  adafruit-circuitpython-rfm9x  circuitpython-base64 circuitpython-base64 circuitpython-esp32connection adafruit-circuitpython-ble-radio circuitpython-nrf24l01 thonny-circuitpython  \
                  Adafruit_Libraries Adafruit-PCA9685 Adafruit-GPIO  raspiSensors  oled-text  pi-ina219 adafruit-ads1x15 adafruit-pureio  OctoPyClient tentacle ledDriver  ampy micropython-uploader \
                  msteamsconnector matplotlib numpy imutils pyodbc  Adafruit-GPIO SQLAlchemy aniso8601 croniter flask-restful flask-sqlalchemy natsort pih2o python-dateutil pytz ; do
    printstatus "Installeren CircuitPython lib: \"${addonnodes}\""
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
done

pip install --upgrade adafruit-blinka

python demo/blinkatest.py &
python demo/ina219demo.py &
# python demo/oatmealDemo.py
echo ""
echo "Circuitpython install afgerond.  Test met: python3 ./demo/blinkatest.py"
echo ""
