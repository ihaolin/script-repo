#!/bin/bash
#
# This is script for mariadb(an opensource branch of mysql) install
#

BASEDIR=$(cd `dirname $0`; pwd)

# must sudo
if [ "$(id -u)" -ne 0 ] ; then
    echo -e "\033[31m You must run this script as sudo. Sorry! \033[0m"
    exit 1
fi

# Set install file
read  -p "Please select mysql tar package full path: " INSTALL_FILE
if [ ! -f "$INSTALL_FILE" ]; then
	echo -e "\033[31m mysql package isn't exist! \033[0m"
	exit 1
fi

# Set install path
read  -p "Please select mysql install path path[/usr/local/mysql]: " INSTALL_PATH
if [ "$INSTALL_PATH" = "" ]; then
	INSTALL_PATH="/usr/local/mysql"
fi
if [ ! -d $INSTALL_PATH ]; then
    echo "mkdir $INSTALL_PATH"
    mkdir -p $INSTALL_PATH
fi

# Set up user
read  -p "Please set mysql user[mysql]: " MYSQL_USER
if [ "$MYSQL_USER" = "" ]; then
	MYSQL_USER=mysql
fi
groupadd $MYSQL_USER
if [ ! "$?" = "0" ]; then
    echo -e "\033[31m Add group $MYSQL_USER fail \033[0m"
    exit 1
fi
useradd -g $MYSQL_USER $MYSQL_USER
if [ ! "$?" = "0" ]; then
    echo -e "\033[31m Add user $MYSQL_USER fail \033[0m"
    exit 1
fi

# Upcompress to install path
echo -e "\033[33m Uncompress tar to $INSTALL_PATH... \033[0m"
tar -zxf $INSTALL_FILE -C $INSTALL_PATH --strip-components=1

# Set mysql's data permission
echo -e "\033[33m chown of $INSTALL_PATH/data to mysql. \033[0m"
chown -R mysql $INSTALL_PATH/data

# Execute mysql_install_db
echo "Installing mysql db"
sh $INSTALL_PATH/scripts/mysql_install_db --user=$MYSQL_USER --basedir=$INSTALL_PATH --datadir=$INSTALL_PATH/data
if [ ! "$?" = "0" ]; then
    echo -e "\033[31m MySQL install db fail. \033[0m"
    exit 1
else
    echo -e "\033[32m Install mysql db ok. \033[0m"
fi

# Set my.cnf
echo -e "\033[33m init MySQL configuration to /etc/my.cnf \033[0m"
if [ -f /etc/my.cnf ]; then
    echo -e "\033[33m Check /etc/my.cnf existed, and mv to /etc/my.cnf.bak \033[0m"
    mv /etc/my.cnf /etc/my.cnf.bak
fi
if [ ! -f /tmp/mysql.sock ]; then
    touch /tmp/mysql.sock
    chown mysql /tmp/mysql.sock
fi
echo "[server]" >> /etc/my.cnf
echo "bind-address           = 0.0.0.0" >> /etc/my.cnf
echo "character-set-server   = utf8" >> /etc/my.cnf
echo "collation-server       = utf8_unicode_ci" >> /etc/my.cnf
echo "init_connect           = 'SET NAMES utf8'" >> /etc/my.cnf
echo "[mysqld]" >> /etc/my.cnf
echo "data=$INSTALL_PATH/data" >> /etc/my.cnf

# Add mysqld service
echo "Copy $INSTALL_PATH/support-files/mysql.server to /etc/init.d/mysqld"
cp $INSTALL_PATH/support-files/mysql.server /etc/init.d/mysqld
chkconfig mysqld on
service mysqld start
if [ ! "$?" = "0" ]; then
    echo -e "\033[31m MySQL service start fail \033[0m"
    exit 1
fi

# Mysql env setting
echo "export MYSQL_HOME=$INSTALL_PATH" >> /etc/profile
echo 'export PATH=$MYSQL_HOME/bin:$PATH' >> /etc/profile
. /etc/profile
echo -e "\033[32m Installed, please source /etc/profile or login. \033[0m"
echo -e "\033[31m Remember: mysqladmin -uroot password [newpassword] \033[0m"
mysql --version

unset BASEDIR
unset INSTALL_FILE
unset INSTALL_PATH
unset MYSQL_USER

exit 0
