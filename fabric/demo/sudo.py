#!/usr/bin/env python
# -*- coding: utf-8 -*-
__author__ = 'haolin'

from fabric.api import *

env.hosts = ['admin@102.terminus.io']

def restart_jetty():
    sudo("service jetty restart")

def unzip():
    with cd("~/project"):
        run("unzip ecp-admin.war -d test")