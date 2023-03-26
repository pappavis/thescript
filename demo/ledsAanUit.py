# 20230325 Circuitpython, bepaal IO_pin status ivm Octopi PSU Control
import digitalio
import board
import time

# 20230326 Let op mijn PSU Controlpin is GPIO14!

class clsMain:
    def __init__(self):
        self.ioPin = 14

        self.led = digitalio.DigitalInOut(board.D14)
        self.led.direction =  digitalio.Direction.OUTPUT

    def main(self):
        print(f'start, PSU Control.GPIO test op GPIO{self.ioPin}')
        time.sleep(1.5)

        print(f'0, pin={self.ioPin} waarde={self.led.value}, direction={digitalio.Direction}')
        time.sleep(1.5)
        self.led.value = False
        print(f'1, pin={self.ioPin} waarde={self.led.value}, direction={digitalio.Direction}')
        time.sleep(1.5)
        self.led.value = True
        print(f'2, pin={self.ioPin} waarde={self.led.value}, direction={digitalio.Direction}')
        time.sleep(1.5)
        #self.led.value = False
        #print(f'3, pin={self.ioPin} waarde={self.led.value}, direction={digitalio.Direction}')
        #time.sleep(1.5)

if __name__ == "__main__":
    print(f"app Start ble_temperature.py")
    main1 = clsMain()
    main1.main()
    print(f"app Eind ble_temperature.py")

