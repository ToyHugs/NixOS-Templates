#!/usr/bin/env python3

import hashlib
import getpass
import pyperclip
import os

passwd = getpass.getpass("Enter your password :")
serviceName = ""


def hashPassword(passwd):
    return hashlib.sha256(passwd.encode('ascii')).hexdigest()


while True:
    serviceName = input("Service name or 'q' to quit :")

    if serviceName == "q":
        passwd = "0"
        break

    elif serviceName != "":
        customPasswd = passwd + serviceName
        customPasswd = hashPassword(customPasswd)

        while customPasswd[0:4] != "0000":
            customPasswd = hashPassword(customPasswd)

        customPasswd = hashPassword(customPasswd)
        customPasswd = customPasswd[0:18] + "A&"

        print("Service Password :")
        print(customPasswd)
        pyperclip.copy(customPasswd)

os.system('clear')