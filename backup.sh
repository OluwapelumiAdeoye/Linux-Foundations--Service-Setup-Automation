#!/bin/bash
set -euo pipefail

DIRECTORY="/opt/myapp"
BACKUP_DIR="/opt/myapp/logs"
LOG_FILE="$BACKUP_DIR/backup.log"
DEST_DIR="$DIRECTORY/backups"
BACKUP_FILE="$DEST_DIR/$(basename "$DIRECTORY")_backup_$(date +%F).tar.gz"


if [ ! -d "$BACKUP_DIR" ]; then
        echo "$BACKUP_DIR not found, so $LOG_FILE cannot be created!" >&2
        exit 1
else
        touch "$LOG_FILE"
        echo "Log file created at $(date)" >> "$LOG_FILE"
fi

if tar -czf "$BACKUP_FILE" -C "$(dirname "$DIRECTORY")" "$(basename "$DIRECTORY")"; then
        echo "$DIRECTORY has been compressed successfully! at $(date)" >> "$LOG_FILE" >&2
else
        echo "ERROR: Unable to compress $DIRECTORY" >> "$LOG_FILE" >&2
fi
