#!/usr/bin/env bash

## some init works

if [ -z $1 ];then
  echo "!!!!!! What are you fucking doing !!!!!!"
  exit
fi

host=$1

initdate=`date +%Y%m%d`

function init_basic() {
  echo "#################### Initial Basic Setting ######################"
  echo "----Dependency----"
  yum -y install openssl-devel
  echo "----LANG----"
  cp /etc/sysconfig/i18n /etc/sysconfig/i18n.bak.$initdate
  echo "LANG=\"en_US.UTF-8\"" > /etc/sysconfig/i18n
  echo "SUPPORTED=\"zh_CN.UTF-8:zh_CN:zh:en_US.UTF-8:en_US:en\"" >> /etc/sysconfig/i18n
  echo "SYSFONT=\"latarcyrheb-sun16\"" >> /etc/sysconfig/i18n
  source /etc/sysconfig/i18n
  cat /etc/sysconfig/i18n

  echo "----HOSTNAME----"
  hostname=`hostname`
  echo "old hostname --> $hostname"
  echo "new hostname --> $host"
  cp /etc/sysconfig/network /etc/sysconfig/network.bak
  sed 's/'${hostname}'/'${host}'/g' /etc/sysconfig/network.bak > /etc/sysconfig/network
  hostname $host

  echo "----HOST----"
  ip=`ifconfig eth0 | grep "inet addr" | cut -d: -f2 | cut -d" " -f1`
  echo "${ip}        ${host}" >> /etc/hosts
  cat /etc/hosts
  echo ""
}

function init_user() {
  echo "#################### Initial USER ######################"
  echo "add group and user"
  groupadd iss
  useradd -g iss -d /mnt/iss iss
  ln -s /mnt/iss /home/iss
  mkdir -p /home/iss/.ssh
  echo "add relay key to auth"
  echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq0ei2dbn8qL0Ix+XDgQ4+NrDACYdhENzWS1FywJya3R+36tWAZfa5Cp4VjEbNmfhj5b7x3fJL93pm0vFGZKstW38z2ypL0EZ5VP3EKC6SAIRYTxWzu74zWQbGziaZwdA4KlvscmlVoZPzJKOvd6Og7tqEscLm35ibREPu62nBuQzekWf+CsVQfgC2NBaC8zYS4ER4XSrdzl5P0Dr/+rNavpRVxLA6b/rIkDGKJab+AlDewUKtKBePRH89hEbmlGLyi5vPNIQliPb85dZV6TqwAbFSuu+DRFZV38MjL+CARFlBWOzvrQFnA0u2i8mwF3sWGO0a0Oke15sr9NdU8jJJQ== iss@iss-relay" >> /home/iss/.ssh/authorized_keys
  echo "chmod authkey file"
  chmod 600 /home/iss/.ssh/authorized_keys
  chown -R iss:iss /mnt/iss/
  echo ""
}

function init_jdk() {
  cd /root
  echo "#################### Initial JDK ######################"
  tar -zxvf jdk-7u67-linux-x64.tar.gz -C /mnt/
  ln -s /mnt/jdk1.7.0_67 /mnt/jdk
  echo "" >> /etc/profile
  echo "JAVA_HOME=/mnt/jdk" >> /etc/profile
  echo "CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/tools.jar" >> /etc/profile
  echo "PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile
  echo "export JAVA_HOME PATH CLASSPATH" >> /etc/profile
  source /etc/profile
  echo ""
}

function init_tomcat() {
  echo "#################### Initial Tomcat ######################"
  tar -zxvf apache-tomcat-8.0.12.tar.gz -C /mnt/
  ln -s /mnt/apache-tomcat-8.0.12 /mnt/tomcat
  echo ""
}

function init_nagios() {
  cd /root
  echo "#################### Initial Nagios ######################"
  groupadd nagios
  useradd -g nagios nagios  -s /sbin/nologin
  tar -zxvf nrpe-2.15.tar.gz
  cd nrpe-2.15
  ./configure --prefix=/mnt/nagios --enable-command-args
  make all
  make install-plugin
  make install-daemon
  make install-daemon-config
  cd /root
  rm -rf nrpe-2.15

  tar -zxvf nagios-plugins-2.0.3.tar.gz
  cd nagios-plugins-2.0.3
  ./configure --prefix=/mnt/nagios
  make
  make install
  cd /root
  rm -rf nagios-plugins-2.0.3

  cd /mnt
  echo "#!/bin/sh
kill \`cat /mnt/nagios/nrpe.pid\`
sudo -u nagios /mnt/nagios/bin/nrpe -c /mnt/nagios/etc/nrpe.cfg -d" > /mnt/nagios/restart.sh
  chmod 744 /mnt/nagios/restart.sh
  chown -R nagios:nagios nagios/
  echo ""
}

function init_collectd() {
  cd /root
  tar -zxvf collectd-5.5.0.tar.gz
  cd collectd-5.5.0
  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libdir=/usr/lib --mandir=/usr/share/man
  make
  make install
  cp contrib/redhat/init.d-collectd /etc/init.d/collectd
  chmod +x /etc/init.d/collectd
  mv ../collectd.conf /etc/
  service collectd restart
}

function init_twemproxy() {
  cd /root
  tar -xvf autoconf-2.69.tar.xz
  cd autoconf-2.69
  ./configure
  make
  make install

  cd /root,
  tar -zxvf twemproxy-0.4.0.tar.gz
  cd twemproxy-0.4.0
  /usr/local/bin/autoreconf -fvi
  ./configure --prefix=/mnt/twemproxy
  make
  make install
  mkdir -p /mnt/twemproxy/conf
}
function init_nginx(){
  echo "#################### Initial Nagios ######################"
}

init_basic
init_user
init_jdk
init_tomcat
init_nagios
init_collectd
init_twemproxy