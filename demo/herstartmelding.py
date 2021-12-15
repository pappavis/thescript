#!/home/pi/venv/venv3.7/bin/python
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import socket

print("Stuur een epost bericht")
gmailUser = 'michiel.erasmus@gmail.com'
gmailPassword = 'G3h31mw@chtw00rd'
recipient = 'swartskaap@gmail.com'

messageHtml = f"""
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="utf-8">
        </head>
        <body>
            <h1>~~kennisgeving~~</h1>
            <p>Raspberru Pi bediener {socket.getfqdn()} is zojuist opnieuw gestart en online</p>
                <p>je kunt via SSH aanmelden met <b>pi@{socket.getfqdn()}.local</b><p>
        </body>
        </html>
    """

msg = MIMEMultipart()
msg['From'] = f'"Michiel Erasmus" <{gmailUser}>'
msg['To'] = recipient
msg['Subject'] = f"{socket.getfqdn()} was opnieuw gestart..."
msg.attach(MIMEText(messageHtml))

try:
    mailServer = smtplib.SMTP('smtp.gmail.com', 587)
    mailServer.ehlo()
    mailServer.starttls()
    mailServer.ehlo()
    mailServer.login(gmailUser, gmailPassword)
    mailServer.sendmail(gmailUser, recipient, msg.as_string())
    mailServer.close()
    print ('Email was verzonden!')
except Exception as ex1:
    print (f'Iets was fout gegaan... {ex1}')

print("EINDE app")

    
