# 20230325 Circuitpython, bepaal IO_pin status ivm Octopi PSU Control
import digitalio
import board
import time

class clsMain:
    def __init__(self):
        self.ioPin = 14

        self.led = digitalio.DigitalInOut(board.D14)
        self.led.direction =  digitalio.Direction.OUTPUT

    def main(self):
        print(f'start, PSU Control.GPIO test op GPIO{ioPin}')
        time.sleep(1.5)

        print(f'0, pin={ioPin} waarde={led.value}, direction={digitalio.Direction}')
        time.sleep(1.5)
        led.value = False
        print(f'1, pin={ioPin} waarde={led.value}, direction={digitalio.Direction}')
        time.sleep(1.5)
        led.value = True
        print(f'2, pin={ioPin} waarde={led.value}, direction={digitalio.Direction}')
        time.sleep(1.5)
        #led.value = False
        #print(f'3, pin={ioPin} waarde={led.value}, direction={digitalio.Direction}')
        #time.sleep(1.5)

if __name__ == "__main__":
    print(f"app Start ble_temperature.py")
    main1 = clsMain()
    main1.main()
    print(f"app Eind ble_temperature.py")


