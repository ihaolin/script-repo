from fabric.api import local, cd, run, env

env.hosts = ['haolin@mysqlmaster',]
#env.password = 'mysqladmin'

def uname_local():
	local("uname -a")

def uname_remote():
	print "remote -uname"
	run("uname -a")