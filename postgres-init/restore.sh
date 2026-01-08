#!/bin/bash
set -e

# Use the variable passed from docker-compose, or default to 'my_db.backup'
FILENAME=${BACKUP_FILENAME}

# Use the variables already defined in your docker-compose environment
echo "--- STARTING RESTORE FROM /docker-entrypoint-initdb.d/$FILENAME ---"

if [ -f "/docker-entrypoint-initdb.d/$FILENAME" ]; then
    pg_restore -v -U "$POSTGRES_USER" -d "$POSTGRES_DB" "/docker-entrypoint-initdb.d/$FILENAME"
    echo "--- RESTORE COMPLETE ---"
else
    echo "WARNING: Backup file $FILENAME not found in /docker-entrypoint-initdb.d/. Skipping restore."
fi
