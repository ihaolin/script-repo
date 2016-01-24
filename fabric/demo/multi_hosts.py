from fabric.api import *

env.roledefs = { 
	'mysql' : ['haolin@mysqlmaster'],
	'zoo' : ['haolin@zooserver']
}

@roles('mysql')
def task1():
	run('uname -a')

@roles('zoo')
def task2():
	run('jps')

def dotask():
	execute(task1)
	execute(task2)