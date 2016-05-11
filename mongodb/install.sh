#!/usr/bin/env bash

MONGO_HOME=$1
if [ "$MONGO_HOME" = '' ]; then
    echo "MONGO_HOME not set"
    exit 1
fi

MONGO_CONF=/etc/mongod.conf
MONGO_LOG_DIR=$MONGO_HOME/log
MONGO_DATA_DIR=$MONGO_HOME/data

mkdir $MONGO_HOME
mkdir $MONGO_LOG_DIR
mkdir $MONGO_DATA_DIR

MONGO_YUM_REPO=/etc/yum.repos.d/mongodb-org-3.2.repo

touch $MONGO_YUM_REPO
echo '
[mongodb-org-3.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc
' >> $MONGO_YUM_REPO

yum install -y mongodb-org

echo '
systemLog:
  destination: file
  logAppend: true
  path: $MONGO_LOG_DIR/mongod.log

storage:
  dbPath: $MONGO_DATA_DIR
  journal:
    enabled: true
' > $MONGO_CONF

chown -R mongod:mongod $MONGO_HOME

chkconfig mongod on

service mongod start
