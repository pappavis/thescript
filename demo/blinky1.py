# https://learn.adafruit.com/circuitpython-on-raspberrypi-linux?view=all

import time
import board
import digitalio
 
print("hello blinky!")
 
led = digitalio.DigitalInOut(board.D16)
led.direction = digitalio.Direction.OUTPUT
 
while True:
    led.value = True
    time.sleep(0.5)
    led.value = False
    time.sleep(0.2)
