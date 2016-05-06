#!/usr/bin/env bash

RABBIT_HOME=$1
if [ "$RABBIT_HOME" = '' ]; then
    echo "RABBIT_HOME not set"
    exit 1
fi
RABBIT_NODE_NAME=$2
if [ "$RABBIT_NODE_NAME" = '' ]; then
    echo "RABBIT_NODE_NAME not set"
    exit 1
fi

RABBIT_LOG_DIR=$RABBIT_HOME/log
RABBIT_DATA_DIR=$RABBIT_HOME/database
RABBIT_ENV_CONF=/etc/rabbitmq/rabbitmq-env.conf
RABBIT_CONF=/etc/rabbitmq/rabbitmq.conf

# update yum
yum -y update

# Add and enable relevant application repositories:
# Note: We are also enabling third party remi package repositories.
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sudo rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm

# Finally, download and install Erlang:
yum install -y erlang

# Download the latest RabbitMQ package using wget:
wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.2.2/rabbitmq-server-3.2.2-1.noarch.rpm

# Add the necessary keys for verification:
rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc

# Install the .RPM package using YUM:
yum -y install rabbitmq-server-3.2.2-1.noarch.rpm

# mkdirs
mkdir -p $RABBIT_HOME
mkdir -p $RABBIT_DATA_DIR
mkdir -p $RABBIT_LOG_DIR
chown -R rabbitmq:rabbitmq $RABBIT_HOME

# env conf
touch $RABBIT_ENV_CONF
echo "RABBITMQ_NODENAME=$RABBIT_NODE_NAME" >> $RABBIT_ENV_CONF
echo "RABBITMQ_CONFIG_FILE=$RABBIT_CONF" >> $RABBIT_ENV_CONF
echo "RABBITMQ_MNESIA_BASE=$RABBIT_DATA_DIR/mnesia" >> $RABBIT_ENV_CONF
echo "RABBITMQ_LOG_BASE=$RABBIT_LOG_DIR" >> $RABBIT_ENV_CONF

# conf
touch $RABBIT_CONF
echo '
[
 {rabbit,
  [
   {tcp_listeners, [5672]}
  ]}
]. ' >> $RABBIT_CONF

# enable basic plugins
sudo rabbitmq-plugins enable rabbitmq_management

# start rabbit from reboot
chkconfig rabbitmq-server on

# start rabbitmq
service rabbitmq start