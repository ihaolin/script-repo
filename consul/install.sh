#!/usr/bin/env bash

CONSUL_PKG=0.5.2_linux_amd64.zip

echo "Downloading consul..."
wget https://dl.bintray.com/mitchellh/consul/$CONSUL_PKG

read  -p "Please select consul install path path[/usr/local/bin/consul]: " INSTALL_PATH
if [ "$INSTALL_PATH" = "" ]; then
	INSTALL_PATH="/usr/local/bin"
fi

unzip $CONSUL_PKG -d $INSTALL_PATH && rm $CONSUL_PKG


unset CONSUL_PKG
unset INSTALL_PATH
