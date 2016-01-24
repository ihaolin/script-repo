import os

print(os.path.exists('test.txt'))
print(os.path.isdir('test.txt'))
print(os.path.isfile('test.txt'))
print(os.path.realpath('test.txt'))

# You can get some metedata

import time

print(time.ctime(os.path.getmtime('test.txt')))
# filesize [byte]
print(os.path.getsize('test.txt'))