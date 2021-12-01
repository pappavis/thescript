#!/home/pi/venv/venv3.7/bin/python
import time
import board
import digitalio
 
print("hello blinky!")
 
ledG = digitalio.DigitalInOut(board.D16)
ledB = digitalio.DigitalInOut(board.D20)
ledR = digitalio.DigitalInOut(board.D21)
ledR.direction = digitalio.Direction.OUTPUT
ledG.direction = digitalio.Direction.OUTPUT
ledB.direction = digitalio.Direction.OUTPUT

if __name__ == "__main__":
    altTel1 = 0

    while(True):
        ledTeKnipperen = None

        if(altTel1 == 0):
            ledTeKnipperen = ledG
        elif(altTel1 == 1):
            ledTeKnipperen = ledR
        else:
            ledTeKnipperen = ledB

        ledTeKnipperen.value = True
        time.sleep(0.5)
        ledTeKnipperen.value = False
        time.sleep(0.2)
        altTel1 += 1

        if(altTel1 > 3):
            altTel1 = 0
