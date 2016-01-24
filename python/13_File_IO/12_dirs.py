import os
import os.path

# list current dir's dirs and files
print(os.listdir('.'));

# list current dir's files
print([name for name in os.listdir('.')
        if os.path.isfile(os.path.join('/', name))])

#list current dir's dirs
print([name for name in os.listdir('.')
        if os.path.isdir(os.path.join('/', name))])

#list curretn dir's .py files
print([name for name in os.listdir('.')
        if name.endswith('.py')])

#equal above
import glob
print(glob.glob('*.py'))

#equal above
from fnmatch import fnmatch
print([name for name in os.listdir('.')
        if fnmatch(name, '*.py')])

import sys

print(sys.getfilesystemencoding())
print(sys.platform)