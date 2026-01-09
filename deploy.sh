#!/bin/bash
set -euo pipefail

ROOT_DIRECTORY="/opt/myapp"
SCRIPT_DIR="$ROOT_DIRECTORY/scripts"
APP_DIR="$ROOT_DIRECTORY/app"
LOGS_DIR="$ROOT_DIRECTORY/logs"
BACKUPS_DIR="$ROOT_DIRECTORY/backups"
LOG_FILE="$LOGS_DIR/deploy.log"

if [ ! -d "$ROOT_DIRECTORY" ]; then
        echo "The root directory $ROOT_DIRECTORY does not exist..." >&2
        exit 1
fi

timestamp() {
        date "+%Y-%m-%d %H:%M:%S"
}

mkdir -p "$SCRIPT_DIR" "$APP_DIR" "$LOGS_DIR" "$BACKUPS_DIR"
touch "$LOG_FILE"
echo "$(timestamp) Directories have been created under $ROOT_DIRECTORY.." >> "$LOG_FILE"

if rsync -av "$APP_DIR/" "$BACKUPS_DIR/" >> "$LOG_FILE" 2>&1; then
        echo "$(timestamp) Deployment files have been copied successfully!" >> "$LOG_FILE"
else
