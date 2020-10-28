import time
 
import board
import busio
import adafruit_bme280
 
# Create library object using our Bus I2C port
i2c = busio.I2C(board.SCL, board.SDA)

cnti2c = i2c.scan()
print("aantal i2c apparaten:", len(cnti2c), ", op adres:", cnti2c)

