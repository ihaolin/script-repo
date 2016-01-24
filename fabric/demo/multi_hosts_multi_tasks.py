from fabric.api import run, env

env.hosts = ['mysqlmaster', 'zooserver']

def taskA():
    run('ls')

def taskB():
    run('whoami')