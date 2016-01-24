from fabric.api import env, roles, task, execute, run, runs_once, put

env.roledefs = {
    'zoo': ['zooserver'],
    'mysql': ['mysqlmaster'],
}

@roles('zoo', 'mysql')
@task
#@runs_once   This will make mysql task can't be executed
def upload():
	put('~/logs/snz', '~/')
    