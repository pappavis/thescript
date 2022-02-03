# This file is executed on every boot (including wake-boot from deepsleep)
#import esp
#esp.osdebug(None)
import upip
import os

print("root dir:", os.listdir("lib"))
print("START module intstall")

libLijst = ["micropython-base64", "micropython-email.encoders", "micropython-email.message", "micropython-email.utils", "micropython-machine", "micropython-pathlib", "micropython-umqtt.simple", "micropython-smtplib", "micropython-usqlite", "micropython-ffilib", "micropython-bmp180"]

for lib in libLijst:
    try:
        upip.install(lib)
    except Exception as ex1:
        print(ex1)

print("", os.listdir("lib"))
print("EIND module intstall")
