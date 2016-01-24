#!/usr/bin/env python
# -*- coding: utf-8 -*-
__author__ = 'xiao'

from fabric.api import lcd, local, cd, local, put, settings, task
from os.path import expanduser
import time

#java projects/ecp dir
java_projects_ecp_dir = "/home/admin/jenkins/workspace/ecp_deploy_service"

@task
def prepare_service(module_name):
    """
    build service(eg: user,item,shop,trade) and upload to server
    """
    backup_service(module_name)
    # package_service(module_name)
    upload_service(module_name)



@task
def backup_service(module_name):
    """
    backup
    """
    with lcd("~"):
        local("[ -d projects/ecp ] || mkdir ~/projects/ecp")
        local("[ -d projects/ecp/{service_name}-service ] || mkdir ~/projects/ecp/{service_name}-service".format(service_name=module_name))
        local("[ -f projects/ecp/{service_name}-service.tar.gz ] || touch ~/projects/ecp/{service_name}-service.tar.gz".format(service_name=module_name))
        local("[ -f projects/ecp/{service_name}-service.tar.gz.bak ] || touch ~/projects/ecp/{service_name}-service.tar.gz.bak".format(service_name=module_name))
        with lcd("~/projects/ecp"):
            local("rm {service_name}-service.tar.gz.bak".format(service_name=module_name))
            local("mv {service_name}-service.tar.gz {service_name}-service.tar.gz.bak".format(service_name=module_name))


@task
def upload_service(module_name):
    """
    upload to server
    """
    with lcd(java_projects_ecp_dir):
        with lcd("ecp-{service_name}/target/jsw/{service_name}-service".format(service_name=module_name)):
            local("chmod a+x bin/*")
            local("[ -d logs ] || mkdir logs")
            with lcd(".."):
                local("tar zcf {service_name}-service.tar.gz {service_name}-service".format(service_name=module_name))
                local("cp {service_name}-service.tar.gz ~/projects/ecp".format(service_name=module_name))


@task
def reload_service(module_name):
    """
    reload service (eg: user,item,shop,trade) and start
    """
    with lcd("~/projects/ecp"):
        local("[ -d {service_name}-service/bin ] && [ -f {service_name}-service/bin/{service_name}-service ] && {service_name}-service/bin/{service_name}-service stop && sleep 5".format(service_name=module_name))
        local("[ -f {service_name}-service/logs/{service_name}-service.pid ] || echo 'stopping {service_name} service successfully' ".format(service_name=module_name))
        local("rm -rf {service_name}-service".format(service_name=module_name))
        local("tar zxf {service_name}-service.tar.gz".format(service_name=module_name))
        local("{service_name}-service/bin/{service_name}-service start".format(service_name=module_name))
        local("sleep 15")
        local("[ -f {service_name}-service/logs/{service_name}-service.pid ] || echo 'start {service_name} failure'".format(service_name=module_name))
        local("[ -f {service_name}-service/logs/{service_name}-service.pid ] || tail -n 50 {service_name}-service/logs/wrapper.log".format(service_name=module_name))
        local("[ -f {service_name}-service/logs/{service_name}-service.pid ] || exit 1".format(service_name=module_name))


@task
def deploy_service(module_name):
    """
    ex usage: fab -f deploy_service.py deploy_service:user
    """
    prepare_service(module_name)
    reload_service(module_name)



@task
def rollback_service(module_name):
    """
    roll back java module, example usage: fab -f deploy_service.py rollback_service: item
    """
    with lcd("~/projects/ecp"):
        local("{service_name}-service/bin/{service_name}-service stop".format(service_name=module_name))
        local("rm -rf {service_name}-service {service_name}-service.tar.gz".format(service_name=module_name))
        local("mv {service_name}-service.tar.gz.bak {service_name}-service.tar.gz".format(service_name=module_name))
        local("tar xzf {service_name}-service.tar.gz".format(service_name=module_name))
        local("{service_name}-service/bin/{service_name}-service start".format(service_name=module_name))

@task
def rollback_all():
    """
    rollback all service
    ex usage: fab -f deploy_all_service.py rollback_all
    """
    services = ["user", "item", "msg", "shop", "trade"]
    for service_name in services:
        rollback_service(service_name)




@task(default=True)
def deploy():
    print "beging to deploy ecp service"
    services = ["user", "item", "msg", "shop", "trade"]
    for service_name in services:
        prepare_service(service_name)
        reload_service(service_name)