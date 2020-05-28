#/usr/bin/sh
echo "Installeer nieuwe python3 virtuale omgeving"
source ~/venv/venv3.7
pip3 install adafruit-blinka adafruit-circuitpython-ble-adafruit install adafruit-circuitpython-ina219 adafruit-circuitpython-tinylora

echo ""
echo "Je moet opnieuw inloggen, en dan uitvoeren: python3 blinkatest.py"
python3 ./blinkatest.py

