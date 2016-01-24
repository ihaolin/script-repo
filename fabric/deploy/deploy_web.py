#!/usr/bin/env python
# -*- coding: utf-8 -*-
__author__ = 'xiao'

from fabric.api import env, lcd, local, cd, sudo, run, put, settings, task, execute
from os.path import expanduser


# env.use_ssh_config = True
env.hosts = ["haier"]
env.password = "duand@$#456beta"

#java project dir
java_project_dir = "/var/data/jenkins/workspace/rrscn_deploy_web/"



@task
def prepare_web(module_name,package_name):
    """
    backup, build web and upload
    """
    backup_web(package_name)
    package_web(module_name)
    upload_web(module_name,package_name)



@task
def backup_web(package_name):
    """
    backup web
    """

    with settings():
        run("[ -d project ] || mkdir ~/project")
        with cd("~/project"):
            run("rm {app_name}.tar.gz.bak".format(app_name=package_name))
            run("mv {app_name}.tar.gz {app_name}.tar.gz.bak".format(app_name=package_name))

@task
def package_web(package_name):
    """
    package web
    """

    with lcd(java_project_dir):
        local("git pull")
        local("mvn clean package -U -X -Dmaven.test.skip -Pprepub -am -pl rrs-{app_name}".format(app_name=package_name))



@task
def upload_web(module_name,package_name):
    """
    upload web package
    """

    with lcd(java_project_dir):
        with lcd("rrs-{module}/target".format(module=module_name)):
            local("tar zcf {package}.tar.gz {package}".format(package=package_name))
            put("{package}.tar.gz".format(package=package_name), "~/project")

@task
def reload_web(package_name):
    """
    reload package
    """
    with cd("~/project"):
        run("rm -rf {package}".format(package=package_name)) 
        run("tar zxf {package}.tar.gz".format(package=package_name))

@task
def restart():
    run("set -m; sudo service jetty restart")


@task(default=True)
def deploy():
    table = { 'rrs-admin':'admin', 'mall':'mall-web'}
    # table = { 'mall':'mall-web'}

    for key in table.keys():
        print key,":",table[key]
        package_name = key;
        module_name = table[key]


        prepare_web(module_name,package_name)
        reload_web(package_name)

    restart()








    