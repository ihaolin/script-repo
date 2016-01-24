# Install redis on Centos 6.x

* set `vm.overcommit_memory=1`, make kernel can allocate all physical memory, whatever current memory is

```bash
vm.overcommit_memory = 1
sudo sysctl vm.overcommit_memory=1
```

* install :

```bash
wget http://download.redis.io/releases/redis-stable.tar.gz
tar zxvf redis-stable.tar.gz
cd redis-stable
make distclean
find src -executable -type f -exec sudo cp {} /usr/bin \ #mv all executable file to /usr/bin
sudo useradd -s /usr/sbin/nologin -r -M redis # add user reds, not have home
sudo chown -R redis:redis /var/data/redis
sudo chown -R redis:redis /var/log/redis
sudo chown -R redis:redis /var/run/redis
```

* config:

```bash
sudo mkdir /etc/redis
sudo cp <path-to-redis>/redis.conf /etc/redis/<port>.conf
```

* vim <port>.conf to persistent:

```bash
daemonize yes
pidfile /var/run/redis/1111.pid
port 1111
logfile /var/log/redis/1111.log
dbfilename 1111.rdb
dir /var/data/redis

# if redis used to save session, you should comment these:
#save 900 1
#save 300 10
#save 60 10000

```

* autostart:

```bash
#!/usr/bin/env bash
#  chkconfig: 3 98 99
# redis        Startup script for Redis Server
#
# description: Redis is an open source, advanced key-value store.
#
# processname: redis-server
# config: /etc/redis/1111.conf
# pidfile: /var/run/redis/1111.pid
EXEC=/usr/bin/redis-server
CLIEXEC=/usr/bin/redis-cli
PIDFILE=/var/run/redis/1111.pid
CONF="/etc/redis/1111.conf"
REDISPORT="1111"
USER=redis

source /etc/init.d/functions

start() {
     if [ -f $PIDFILE ]
     then
         echo "$PIDFILE exists, process is already running or crashed"
     else
         echo "Starting Redis server..."
         daemon --user=$USER $EXEC $CONF
         echo
     fi
}

stop() {
    if [ ! -f $PIDFILE ]
    then
        echo "$PIDFILE does not exist, process is not running"
    else
        PID=$(cat $PIDFILE)
        echo "Stopping ..."
        $CLIEXEC -p $REDISPORT shutdown
        while [ -x /proc/${PID} ]
        do
            echo "Waiting for Redis to shutdown ..."
            sleep 1
        done
        echo "Redis stopped"
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo "Please use start or stop as first argument"
        ;;
esac

sudo chmod +x /etc/init.d/redis_1111
```

* chkconfig

```bash
sudo chkconfig --add redis_6379
udo chkconfig --level 345 redis_6379 on
```

* manage service

```bash
sudo service redis_1111 start # 启动在1111端口的redis实例
sudo service redis_1111 stop  # 停止在1111端口的redis实例
sudo service redis_1111 restart # 重启在1111端口的redis实例
```