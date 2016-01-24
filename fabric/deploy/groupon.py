__author__ = 'haolin'

from fabric.api import *
from fabric.contrib.files import exists

env.roledefs = {
    # test host
    'test': ['admin@122.224.200.210'],
    # prod host
    'prod': ['admin@web001'],
    'mysql001': ['admin@mysql001']
}

golbat_dirs = {
    'test': "/var/data/jenkins/workspace/groupon_deploy_golbat_prepare",
    'prod': "/var/data/jenkins/workspace/groupon_deploy_golbat",
    'mysql001': "/var/data/jenkins/workspace/groupon_deploy_golbat"
}

mobile_dirs = {
    'test': "/var/data/jenkins/workspace/groupon_deploy_mobile_prepare/mobile/target",
    'prod': "/var/data/jenkins/workspace/groupon_deploy_mobile/mobile/target"
}

remote_groupon_frontend_dir = "~/assets/groupon"
remote_groupon_backend_dir = "~/projects/groupon"

# bakcup backend
def backup_backend(pkg_name):
    if not exists(remote_groupon_backend_dir):
        run("mkdir -p " + remote_groupon_backend_dir)
    with cd(remote_groupon_backend_dir):
        if exists("{pkg_name}.bak".format(pkg_name=pkg_name)):
            run("rm -rf {pkg_name}.bak".format(pkg_name=pkg_name))
        if exists("{pkg_name}".format(pkg_name=pkg_name)):
            run("mv {pkg_name} {pkg_name}.bak".format(pkg_name=pkg_name))

# upload backend
def upload_backend(pkg_path, pkg_name):
    with lcd(pkg_path):
        put("{pkg_name}.war".format(pkg_name=pkg_name), remote_groupon_backend_dir)
    with cd(remote_groupon_backend_dir):
        run("unzip {pkg_name}.war -d {pkg_name}".format(pkg_name=pkg_name))

# backup frontend
def backup_frontend(pkg_name):
    if not exists(remote_groupon_frontend_dir):
        run("mkdir -p " + remote_groupon_frontend_dir)
    with cd(remote_groupon_frontend_dir):
        if exists("{pkg_name}".format(pkg_name=pkg_name)):
            if exists("{pkg_name}.bak".format(pkg_name=pkg_name)):
                run("rm -rf {pkg_name}.bak".format(pkg_name=pkg_name))
            run("mv {pkg_name} {pkg_name}.bak".format(pkg_name=pkg_name))

# upload frontend
def upload_frontend(pkg_path, pkg_name):
    with lcd(pkg_path):
        local("rake package")
        put("{pkg_name}.zip".format(pkg_name=pkg_name), remote_groupon_frontend_dir)
    with cd(remote_groupon_frontend_dir):
        run("unzip {pkg_name}.zip".format(pkg_name=pkg_name))
        run("mv public {pkg_name}".format(pkg_name=pkg_name))

# dispath upload
def dispatch_frontend(pkg_path, pkg_name):
    with lcd(pkg_path):
        local("rake package")
        put("{pkg_name}.zip".format(pkg_name=pkg_name), remote_groupon_frontend_dir)
    with cd(remote_groupon_frontend_dir):
        run("unzip {pkg_name}.zip".format(pkg_name=pkg_name))
        if exists("{pkg_name}".format(pkg_name=pkg_name)):
            run("rm -rf {pkg_name}".format(pkg_name=pkg_name))
        run("mv public {pkg_name}".format(pkg_name=pkg_name))

def restart(service_name):
    run("set -m; sudo service {service_name} restart".format(service_name=service_name))

@task
def deploy_mobile():
    backup_backend("mobile")
    upload_backend(mobile_dirs[env.roles[0]], "mobile")
    restart("jetty-groupon-mobile")

@task
def deploy_golbat():
    backup_frontend("golbat")
    upload_frontend(golbat_dirs[env.roles[0]], "golbat")

@task
def dispatch_golbat():
    dispatch_frontend(golbat_dirs[env.roles[0]], "golbat")





