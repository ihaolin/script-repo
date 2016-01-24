#!/bin/sh

## update default ruby source to taobao

gem sources --remove https://rubygems.org/ && gem sources -a https://ruby.taobao.org && gem sources -l