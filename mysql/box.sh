#!/bin/bash
#
# This is a script for mysql
#

MYSQL_HOST=localhost
MYSQL_USER="root"
MYSQL_PASSWORD="root"
MYSQL_BACKUP_DIR=~/data
MYSQL_LOG_DIR=~/data

if [ ! -d $MYSQL_BACKUP_DIR ]; then
    mkdir -p $MYSQL_BACKUP_DIR
fi
MYSQL_LOG_FILE=$MYSQL_LOG_DIR/mysql.log

if [ ! -d $MYSQL_BACKUP_DIR ];then
    mkdir -p $MYSQL_BACKUP_DIR
fi

if [ ! -d $MYSQL_LOG_DIR ];then
    mkdir -p $MYSQL_LOG_DIR
fi

backup()
{
    local db=$1
    echo "-----------------MySQL.[$db] Backup start[$(date +%Y-%m-%d_%H:%M:%S)]-----------------" >> $MYSQL_LOG_FILE
    mysqldump -q -u$MYSQL_USER -p$MYSQL_PASSWORD $db > "$MYSQL_BACKUP_DIR/mysql-$db-$(date +%Y-%m-%d-%H-%M-%S).sql"
    if [ "$?" = "0" ]; then
        echo -e "\033[32m [$db] backuped.\033[0m" >> $MYSQL_LOG_FILE
    else
        echo -e "\033[31m [$db] backup failed. \033[0m" >> $MYSQL_LOG_FILE
        return 1
    fi
    echo "-----------------MySQL.[$db] Backup end[$(date +%Y-%m-%d_%H:%M:%S)]-----------------" >> $MYSQL_LOG_FILE
    return 0
}

restore()
{
    echo "script waiting to finish"
    return 0
}

processes_state()
{
    local tempfile=$(mktemp tempfile.XXX)
    mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -s -e "show processlist\G" > $tempfile
    grep State: $tempfile | sort | uniq -c  | sort -rn
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

    '-s')
        processes_state
        ;;
    *)
        echo "Usage: ( -b | -r )
            -b : backup mysql
            -r : restore mysql
            -ps : mysql process list state
            -is : mysql innodb status
        "
esac

unset MYSQL_HOST
unset MYSQL_USER
unset MYSQL_PASSWORD
unset MYSQL_BACKUP_DIR
unset MYSQL_LOG_DIR
unset MYSQL_LOG_FILE
unset args
unset options

exit 0