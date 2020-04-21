#!/bin/bash

if pidof -o %PPID -x "local-backup.sh"; then
    echo "locale-backup already running"
    exit 1
fi

# logfile
LOG_FILE="/mnt/media1/logs/local-backup.log"

# backup location from
FROM_PATH="/mnt/media1/photos/"

# backup location to
TO_PATH="/mnt/backup1/photos"

echo "local backup started $(date)" >> $LOG_FILE 2>&1

rsync -avu --delete $FROM_PATH $TO_PATH --log-file=$LOG_FILE

if [ $? -eq 0 ]; then
    echo "local backup completed $(date)" >> $LOG_FILE 2>&1
    exit 0
else
    echo "local backup failed $(date). rclone exit code $?" >> $LOG_FILE 2>&1
    exit 1
fi
