#!/bin/bash

if pidof -o %PPID -x "google-drive-backup.sh"; then
    echo "google-drive-backup already running"
    exit 1
fi

# logfile
LOG_FILE="/mnt/media1/logs/google-drive-backup.log"

# backup location from
FROM_PATH="/mnt/media1/photos/"

# backup location to
TO_PATH="google-drive:/Photos/"

# bandwidth limit schedule
BW_LIMIT="07:00,5M 23:00,off"

echo "Google Drive backup started $(date)" >> $LOG_FILE 2>&1

rclone sync $FROM_PATH $TO_PATH --bwlimit "$BW_LIMIT" --log-file $LOG_FILE -v

if [ $? -eq 0 ]; then
    echo "Google Drive backup completed $(date)" >> $LOG_FILE 2>&1
    exit 0
else
    echo "Google Drive backup failed $(date). rclone exit code $?" >> $LOG_FILE 2>&1
    exit 1
fi
