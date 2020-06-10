#/usr/bin/sh
echo "Installeer nieuwe python3 virtuale omgeving"
source ~/venv/venv3.7/bin/activate 
python3 -m pip install rpi.gpio adafruit-blinka adafruit-circuitpython-ble-adafruit adafruit-circuitpython-ina219 adafruit-circuitpython-tinylora adafruit-circuitpython-ssd1306 
python3 -m pip install adafruit-circuitpython-miniqr adafruit-circuitpython-turtle adafruit-circuitpython-74hc595 adafruit-circuitpython-display-button adafruit-circuitpython-mpu6050 adafruit-circuitpython-ina260 adafruit-circuitpython-ssd1306 adafruit-circuitpython-ble  adafruit-circuitpython-ble-heart-rate adafruit-circuitpython-ble-broadcastnet adafruit-circuitpython-binascii  adafruit-circuitpython-onewire adafruit-circuitpython-motor  adafruit-circuitpython-hts221 adafruit-circuitpython-midi adafruit-circuitpython-bmp280  adafruit-circuitpython-bme680 adafruit-circuitpython-dotstar  adafruit-circuitpython-max7219 adafruit-circuitpython-display-text adafruit-circuitpython-rfm69 adafruit-circuitpython-dht adafruit-circuitpython-ble-apple-media adafruit-circuitpython-bme280 adafruit-circuitpython-bitbangio adafruit-circuitpython-led-animation adafruit-circuitpython-ble-midi adafruit-circuitpython-sd adafruit-circuitpython-neopixel adafruit-circuitpython-hid adafruit-circuitpython-gps  adafruit-circuitpython-rfm9x  circuitpython-base64 circuitpython-base64 circuitpython-esp32connection adafruit-circuitpython-ble-radio circuitpython-nrf24l01 thonny-circuitpython 

python3 -m pip install Adafruit_Libraries Adafruit-PCA9685 Adafruit-GPIO  raspiSensors  oled-text  pi-ina219
python3 -m pip install OctoPyClient tentacle ledDriver
python3 -m pip install ampy micropython-uploader
python3 -m pip install  Adafruit-GPIO SQLAlchemy adafruit-ads1x15 adafruit-pureio aniso8601 croniter flask-restful flask-sqlalchemy natsort pih2o python-dateutil pytz


echo ""
echo "Je moet opnieuw inloggen, en dan uitvoeren: python3 blinkatest.py"
echo ""
python3 demo/blinkatest.py
python demo/ina219demo.py
# python demo/oatmealDemo.py
