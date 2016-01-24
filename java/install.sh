#!/bin/sh
BASEDIR=$(cd `dirname $0`; pwd)

# must sudo
if [ "$(id -u)" -ne 0 ] ; then
    echo -e "\033[31m You must run this script as sudo. Sorry! \033[0m"
    exit 1
fi

read  -p "Please select java tar package full path: " INSTALL_FILE
if [ ! -f "$INSTALL_FILE" ]; then
	echo -e "\033[31m java package is missing! \033[0m"
	exit 1
fi

# Set install path
read  -p "Please select java install path path[/usr/local/java]: " INSTALL_PATH
if [ "$INSTALL_PATH" = "" ]; then
	INSTALL_PATH="/usr/local/java"
fi
if [ ! -d $INSTALL_PATH ]; then
    echo "mkdir $INSTALL_PATH"
    mkdir -p $INSTALL_PATH
fi


echo "uncompress $INSTALL_FILE to $INSTALL_PATH"
if [ -w $INSTALL_PATH ]; then
  tar -zxvf $INSTALL_FILE -C $INSTALL_PATH --strip-components=1
else
  sudo tar -zxvf $INSTALL_FILE -C $INSTALL_PATH --strip-components=1
fi

echo "Setting java environment..."
echo "export JAVA_HOME=$INSTALL_PATH" | sudo tee -a /etc/profile
echo 'export PATH=$JAVA_HOME/bin:$PATH' | sudo tee -a /etc/profile
. /etc/profile
java -version
if [ "$?" = "0" ]; then
echo -e "\033[32m Installed, please source /etc/profile or relogin. \033[0m"
else
echo -e "\033[31m Install failed. \033[0m"
fi


unset BASEDIR
unset INSTALL_PATH
unset INSTALL_FILE

exit 0
