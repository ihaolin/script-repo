#!/bin/bash

BASEDIR=$(cd `dirname $0`; pwd)

# must sudo
if [ "$(id -u)" -ne 0 ] ; then
    echo -e "\033[31m You must run this script as sudo. Sorry! \033[0m"
    exit 1
fi

# Set install file
read  -p "Please select redis tar package full path: " INSTALL_FILE
if [ ! -f "$INSTALL_FILE" ]; then
	echo -e "\033[31m redis package isn't exist! \033[0m"
	exit 1
fi

# Set install path
read  -p "Please select redis install path path[/usr/local/redis]: " INSTALL_PATH
if [ "$INSTALL_PATH" = "" ]; then
	INSTALL_PATH="/usr/local/redis"
fi
if [ ! -d $INSTALL_PATH ]; then
    echo "mkdir $INSTALL_PATH"
    mkdir -p $INSTALL_PATH
fi

# Uncompress
tar -zxf $INSTALL_FILE -C $INSTALL_PATH --strip-components=1

# check gcc for make
gcc --version
if [ ! "$?" = "0" ]; then
    echo -e "\033[33m Not found gcc, trying install gcc. \033[0m"
    yum install -y gcc
    if [ "$?" = "0" ]; then
        echo -e "\033[32m Gcc installed. \033[0m"
    else
        echo -e "\033[31m Gcc install failed. \033[0m"
        exit 1
    fi
fi

# make
cd $INSTALL_PATH && make MALLOC=libc && make $BASEDIR
if [ ! "$?" = "0" ]; then
    echo -e "\033[31m Make failed. \033[0m"
    exit 1
fi

# check tcl for make test
which tclsh
if [ ! "$?" = "0" ]; then
     echo -e "\033[33m Trying install tcl 8.5 or newer \033[0m"
     yum -y install tcl
     if [ "$?" = "0" ]; then
        echo -e "\033[32m Tcl installed. \033[0m"
    else
        echo -e "\033[31m Tcl install failed. \033[0m"
        exit 1
    fi
fi

# make test
echo -e "\033[33m Making test... \033[0m"
cd $INSTALL_PATH && make test && cd $BASEDIR
if [ ! "$?" = "0" ]; then
    echo -e "\033[31m Test failed. \033[0m"
    exit 1
fi

# make install binary
echo -e "\033[33m Installing binary to... \033[0m"
cd $INSTALL_PATH && make install && cd $BASEDIR
if [ ! "$?" = "0" ]; then
    echo -e "\033[31m Install binary failed. \033[0m"
    exit 1
fi

# Install server
echo -e "\033[33m Installing redis server... \033[0m"
sh $INSTALL_PATH/utils/install_server.sh

unset BASEDIR
unset INSTALL_FILE
unset INSTALL_PATH

exit 0
