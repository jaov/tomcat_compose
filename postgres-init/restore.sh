#!/bin/bash
set -e # Stop immediately if a command fails

echo "Starting Restore Process..."

# Use the variables already defined in your docker-compose environment
pg_restore -v -U "$POSTGRES_USER" -d "$POSTGRES_DB" /docker-entrypoint-initdb.d/my_db.backup

echo "Restore Complete!"
