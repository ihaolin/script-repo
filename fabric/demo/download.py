from fabric.api import env, roles, task, execute, run, runs_once, get

env.roledefs = {
    'zoo': ['zooserver'],
    'mysql': ['mysqlmaster'],
}

@roles('zoo')
@task
def download():
	get('data', '~/')
    