from fabric.api import env, roles, task, execute, run, runs_once

env.roledefs = {
    'test': ['localhost'],
    'prod': ['localhost'],
}

@task
def workhorse():
    return run("uname -a")

@task
def go():
    print env.roles[0]