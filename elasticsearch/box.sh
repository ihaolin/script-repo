#!/usr/bin/env bash

ES_HOME=~/Envir/server/es/es1
ES_PID_FILE=~/Envir/server/es/es1/es.pid
# java options such as: -Xmx512m -Xms512m
JAVA_OPTIONS="-Xmx512m -Xms512m"
# -d run in background
BACKGROND="-d"
REST_URL="localhost:9200"

start()
{
    local script=$ES_HOME/bin/elasticsearch
    $script -p $ES_PID_FILE  $JAVA_OPTIONS $BACKGROND
    echo "Started"
    return 0
}

stop()
{
    if [ ! -f $ES_PID_FILE ]; then
        echo "$ES_PID_FILE isn't exist, maybe elasticsearch isn't running."
        return 1
    fi
    local pid=$(cat $ES_PID_FILE)
    if [ "$pid" = "" ]; then
       echo "pid is empty in file $ES_PID_FILE, maybe elasticsearch isn't running."
       return 1
    fi
    kill -9 $pid
    rm $ES_PID_FILE
    echo "Stopped."
    return 0
}

nodes()
{
    curl "$REST_URL/_cat/nodes?v"
    return 0
}

indexs()
{
    curl "$REST_URL/_cat/indices?v"
    return 0
}

master()
{
    curl "$REST_URL/_cat/master?v"
    return 0
}

alloc()
{
    curl "$REST_URL/_cat/allocation?v"
    return 0
}

kat()
{
    curl -XGET "$REST_URL/$1?pretty"
    return 0
}

case "$1" in

    'start')
        start
        ;;

    'stop')
        stop
        ;;

    'restart')
        stop
        start
        ;;

    'nodes')
        nodes
        ;;

    'indexs')
        indexs
        ;;

    'master')
        master
        ;;

    'alloc')
        alloc
        ;;

     'kat')
        kat $2
        ;;
    *)
        echo "Usage:
        start   : start es.
        stop    : stop es.
        restart : restart es.
        nodes   : nodes informations.
        indexes : all index informations.
        master  : master information.
        alloc   : disk allocation informastions.
        kat     : cat an document, such as: kat /persons/person/{document ID}
        "
esac

unset ES_HOME
unset ES_PID_FILE
unset JAVA_OPTIONS
unset BACKGROND
unset REST_URL

