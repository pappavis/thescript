# This file is executed on every boot (including wake-boot from deepsleep)
#import esp
#esp.osdebug(None)
import upip
import os

print("root dir:", os.listdir("lib"))
print("START module intstall")

try:
    upip.install("micropython-base64")
    upip.install("micropython-email.encoders")
    upip.install("micropython-email.message")
    upip.install("micropython-email.utils")
    upip.install("micropython-machine")
    upip.install("micropython-os.path")
    upip.install("micropython-pathlib")
    upip.install("micropython-pystone")
    upip.install("micropython-runpy")
    upip.install("micropython-types")
    upip.install("micropython-zipfile")
    upip.install("micropython-umqtt.simple")
    upip.install("micropython-umqtt.robust")
    upip.install("micropython-pwd")
    upip.install("micropython-runpy")
    upip.install("micropython-smtplib")
    upip.install("micropython-bmp180")
    upip.install("micropython-ffilib")
    #upip.install("micropython-sqlite3")
except Exception as ex1:
    print("fout:", ex1)
    
print("", os.listdir("lib"))
print("EIND module intstall")
