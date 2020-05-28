# https://pypi.org/project/oatmeal/
from oatmeal import OatmealDevice

class MyDevice(OatmealDevice):
    ROLE_STR = "MyDevice"

board = MyDevice.find()
print("Temperature: ", board.send_and_ack("TMPR").args[0])


