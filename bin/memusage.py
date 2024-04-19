#!/usr/bin/python3

import psutil

mempercent = psutil.virtual_memory()[2]

print(mempercent)
