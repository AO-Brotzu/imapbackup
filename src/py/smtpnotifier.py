#!/usr/bin/env python -u

"""SMTP email sender"""
__version__ = "1.h"
__author__ = "Enrico Sanna "
__copyright__ = "(C) 2020 Enrico Sanna. Code under MIT License.(C)"
__contributors__ = ""


import gc
import smtplib, ssl
# Import the email modules we'll need
from email.mime.text      import MIMEText
from email.mime.multipart import MIMEMultipart
import localconfig

class SMTPNotifier:

    def __init__(self):
        self.smtp_server  = localconfig.smtp_server
        self.port         = localconfig.port
        self.sender_email = localconfig.sender_email
        self.password     = localconfig.password

        print (self.smtp_server)
        print (self.port)
        print (self.sender_email)
        print (self.password)

    def sendLog(self, recipients, messageBody):
        # Create a secure SSL context
        context = ssl.create_default_context()
        context.check_hostname = False
        context.verify_mode=ssl.CERT_NONE
        # Try to log in to server and send email
        try:
            server = smtplib.SMTP(self.smtp_server,self.port,context)
            server.ehlo() # Can be omitted
            server.starttls() # Secure the connection
            server.ehlo() # Can be omitted
            server.login(self.sender_email, self.password)
            sender_email = self.sender_email
            message = MIMEMultipart("alternative")
            message["Subject"] = "Backup email"
            message["From"] = self.sender_email
            message["To"] = recipients
            # Add body to email
            body = messageBody
            message.attach(MIMEText(body, "plain"))
            server.sendmail(self.sender_email, recipients, message.as_string())
            print("email sent to: "+recipients)
        except Exception as e:
            # Print any error messages to stdout
            print(e)
        finally:
            server.quit()

