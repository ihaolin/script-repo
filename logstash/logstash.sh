#!/bin/sh
### BEGIN INIT INFO
# Provides:          logstash
# Required-Start:    $network $remote_fs $named
# Required-Stop:     $network $remote_fs $named
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Starts logstash
# Description:       Starts logstash
### END INIT INFO

PATH=/sbin:/usr/sbin:/bin:/usr/bin
SCRIPTNAME=$(basename $0)
LS_HOME=/letv/logstash

DAEMON=$LS_HOME/bin/logstash
CONF_FILE=$LS_HOME/conf/$SCRIPTNAME.conf
PIDFILE=/var/run/$SCRIPTNAME.pid
LOG_FILE=$LS_HOME/log/$SCRIPTNAME.log


# for logstash env vars
export HOME=$LS_HOME

pid_file_exists() {
    [ -f "$PIDFILE" ]
}

do_start() {
    if pid_file_exists
    then
        echo "Logstash is already running"
    else
        $DAEMON -f $CONF_FILE 1>"$LOG_FILE" 2>&1 &
        echo $! > "$PIDFILE"
        PID=$!
        if [ "$PID" > 0 ]
        then
            echo "Logstash started with pid $!"
        else
            echo "Logstash could not be started"
        fi
    fi
}

do_status() {
    if pid_file_exists
    then
        PID=$(cat $PIDFILE)
        STATUS=$(ps ax | grep $PID | grep -v grep | awk '{print $1}')

        if [ "$STATUS" == "$PID" ]
        then
            echo "Logstash is running on proccess $PID"
        else
            echo "Logstash is NOT running"
            rm $PIDFILE
        fi
    else
        echo "Logstash is NOT running"
    fi
}

do_stop() {
    if pid_file_exists
    then
        PID=$(cat $PIDFILE)
        STATUS=$(ps ax | grep $PID | grep -v grep | awk '{print $1}')

        if [ "$STATUS" == "$PID" ]
        then
            echo "Killing Logstash...."
            KILL=$(kill -15 $PID)
            rm $PIDFILE
            sleep 1
            echo -e "\tLogstash (PID:$PID) killed"
        else
            echo "Logstash is NOT running"
            rm $PIDFILE
        fi
    else
        echo "Logstash is NOT running"
    fi
}

case "$1" in
  start)
        do_start
        ;;
  stop)
        do_stop
        ;;
  status)
        do_status
        ;;
  restart)
        do_stop
        do_start
        ;;
  *)
        echo "Usage: $SCRIPTNAME {start|stop|status|restart}" >&2
        exit 3
        ;;
esac

echo
exit 0