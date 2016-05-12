#!/usr/bin/env bash

FDFS_HOME=$1
if [ "$FDFS_HOME" = '' ]; then
    echo "FDFS_HOME not set"
    exit 1
fi

export LANGUAGE="en_US"
export LC_ALL="C"
export LC_CTYPE="UTF-8"
export LANG="en_US.UTF-8"

git clone git@github.com:happyfish100/libfastcommon.git

# install libfastcommon
cd libfastcommon/
./make.sh
./make.sh install
cd ..

# install fastdfs
tar -zxf FastDFS_v5.05.tar.gz
cd FastDFS
./make.sh
./make.sh install

mkdir -p $FDFS_HOME

groupadd fastdfs
useradd -g fastdfs fastdfs
chown -R fastdfs:fastdfs $FDFS_HOME

