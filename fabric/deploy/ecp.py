#!/usr/bin/env python
# -*- coding: utf-8 -*-
__author__ = 'haolin'

from fabric.api import *
from fabric.contrib.files import exists

local_backend_dir = "/var/data/jenkins/workspace/ecp_deploy_backend_102/"
# local_backend_dir = "/Users/haolin/Working/projects/terminus-ecp/"
local_admin_dir = "/var/data/jenkins/workspace/ecp_deploy_admin_102/ecp-admin/target"
local_web_dir = "/var/data/jenkins/workspace/ecp_deploy_web_102/ecp-web/target"
local_alakazam_dir = "/var/data/jenkins/workspace/ecp_deploy_alakazam_102/"
local_mewtwo_dir = "/var/data/jenkins/workspace/ecp_deploy_mewtwo_102/"

env.roledefs = {
    '102': ['admin@102.terminus.io'],
    'ecp-web': ['admin@102.terminus.io'],
    'ecp-admin': ['admin@102.terminus.io'],
    'ecp-alakazam': ['admin@102.terminus.io'],
    'ecp-mewtwo': ['admin@102.terminus.io']
}

def backup(pkg_name):
    with settings():
        run("[ -d ~/project ] || mkdir ~/project")
        with cd("~/project"):
            if exists("{pkg_name}".format(pkg_name=pkg_name)):
                run("mv {pkg_name} {pkg_name}.bak".format(pkg_name=pkg_name))

def upload_backend(project_root, pkg_name):
    with lcd(project_root):
        put("{pkg_name}.war".format(pkg_name=pkg_name), "~/project")

    with cd("~/project"):
        run("unzip -o {pkg_name}.war -d {pkg_name}".format(pkg_name=pkg_name))

def upload_frontend(project_root, pkg_name):
    with lcd(project_root):
        local("rake tar")
        put("{pkg_name}.tar.gz".format(pkg_name=pkg_name), "~/project")
    with cd("~/project"):
        run("tar zxf {pkg_name}.tar.gz".format(pkg_name=pkg_name))

@roles('102')
@task
def restart():
    sudo("service jetty restart")

@roles('ecp-admin')
@task
def deploy_admin():
    backup('ecp-admin.war')
    upload_backend(local_admin_dir, 'ecp-admin')
    restart()

@roles('ecp-web')
@task
def deploy_web():
    backup('ecp-web.war')
    upload_backend(local_web_dir, 'ecp-web')
    restart()

@roles('102')
@task
def deploy_backend():
    backup('ecp-admin.war')
    upload_backend(local_backend_dir + "ecp-admin/target", 'ecp-admin')
    backup('ecp-web.war')
    upload_backend(local_backend_dir + "ecp-web/target", 'ecp-web')
    restart()

@roles('ecp-mewtwo')
@task
def deploy_mewtwo():
    backup('mewtwo.tar.gz')
    upload_frontend(local_mewtwo_dir, 'mewtwo')

@roles('ecp-alakazam')
@task
def deploy_alakazam():
    backup('alakazam.tar.gz')
    upload_frontend(local_alakazam_dir, 'alakazam')

@roles('102')
@task
def deploy_frontend():
    backup('alakazam.tar.gz')
    upload_frontend(local_alakazam_dir, 'alakazam')
    backup('mewtwo.tar.gz')
    upload_frontend(local_mewtwo_dir, 'mewtwo')

@roles('102')
@task
def deploy_all():
    deploy_admin()
    deploy_alakazam()
    deploy_web()
    deploy_mewtwo()
    restart()




