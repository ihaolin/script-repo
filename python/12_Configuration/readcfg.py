from configparser import ConfigParser

cfg = ConfigParser()

# read info from config file
cfg.read('config.ini')
print(cfg)
print(cfg.sections())
print(cfg.get('installation', 'library'))
print(cfg.get('installation','PREFIX'))
print(cfg.getboolean('debug', 'log_errors'))
print(cfg.getint('server', 'port'))
print(cfg.getint('server', 'nworkers'))
print(cfg.get('server', 'signature'))

# write info into config file
cfg.set('server', 'port', '9000')
cfg.set('debug', 'log_errors', 'False')

import sys
cfg.write(sys.stdout)