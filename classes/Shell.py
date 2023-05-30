#!/usr/bin/env python3
## Summon - some01 LINUX Build Tool
##  This is the future of some01 Linux.
## Python Class: Shell - Do Shell Stuff.
##
##
import subprocess
from classes.Style import Style
import requests ## HTTP requests to check internet connection

class Shell():
    def __init__(self):
        self.style = Style()

    ## Run any command:
    def run_cmd(self,cmd):
        from rich.status import Status
        with Status(f"{self.style.CMNT}Running Command: {self.style.RST}{self.style.GRN}{cmd[0]}{self.style.RST}") as status:
            output = subprocess.run(
                cmd, ## Comment out the DEVNULL lines to debug:
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE
                )
            return output.stdout.decode("UTF-8").replace("\n", "")

    ## Check internet connection:
    def check_internet(self):
        try:
            response = requests.get("https://some01.tz")
            if response.status_code==200:
                return True
            else:
                return False
        except:
            return False