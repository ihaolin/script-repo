#!/bin/bash
#
# This is a script for redis
#

REDIS_HOST=localhost
REDIS_BACKUP_DIR=~/data
if [ ! -d $REDIS_BACKUP_DIR ];then
    mkdir -p $REDIS_BACKUP_DIR
fi

REDIS_LOG_DIR=~/data
if [ ! -d $REDIS_LOG_DIR ];then
    mkdir -p $REDIS_LOG_DIR
fi

REDIS_LOG_FILE=$REDIS_LOG_DIR/redis.log

backup()
{
    local port=$1
    local task="[Redis:$port]"
    echo "---------------------Backuping $task. start[$(date +%Y-%m-%d_%H:%M:%S)] -----------------------" >> $REDIS_LOG_FILE
    echo "saving..." >> $REDIS_LOG_FILE
    redis-cli -h $REDIS_HOST -p $port save >> $REDIS_LOG_FILE
    if [ ! "$?" = "0" ]; then
        echo -e "\033[31m save failed. \033[0m" >> $REDIS_LOG_FILE
        return 1
    else
        echo -e "\033[32m saved.\033[0m" >> $REDIS_LOG_FILE
    fi

    local conf_file=$(redis-cli -h $REDIS_HOST -p $port info | grep config_file | awk -F ":" '{print $2}' | tr -d "\r")
    echo "reading redis conf: $conf_file" >> $REDIS_LOG_FILE
    local data_dir=$(cat $conf_file | grep -w dir | awk '{print $2}')
    local dbfile_name=$(cat $conf_file | grep -m 1 -w dbfilename | awk '{print $2}')

    if [ "$dbfile_name" = "" ]; then
       dbfile_name="dump.rdb"
    fi

    local dbfile_path="$data_dir$dbfile_name"
    local backup_filename=$(echo $dbfile_name | tr -d .rdb)
    local backup_filepath="$REDIS_BACKUP_DIR/redis-$backup_filename-$(date +%Y-%m-%d-%H-%M-%S).rdb"
    echo "cp $dbfile_path to $backup_filepath" >> $REDIS_LOG_FILE
    cp $dbfile_path $backup_filepath

    if [ "$?" = "0" ]; then
        echo -e "\033[32m backuped.\033[0m" >> $REDIS_LOG_FILE
    else
        echo -e "\033[31m backup failed.\033[0m" >> $REDIS_LOG_FILE
        return 1
    fi
    echo "--------------------- Backup $task. end[$(date +%Y-%m-%d_%H:%M:%S)]  -----------------------" >> $REDIS_LOG_FILE
    return 0
}

restore()
{
    echo "script waiting to finish"
    return 0
}

args=($@)
options=${args[@]:1:100}

case "$1" in

    '-b')
        backup ${options[@]}
        ;;

    '-r')
        restore ${options[@]}
        ;;

    *)
        echo "Usage: ( -b | -r )
            -b : backup redis
            -r : restore redis
        "
esac

unset REDIS_HOST
unset REDIS_BACKUP_DIR
unset REDIS_LOG_DIR
unset args
unset options

exit 0