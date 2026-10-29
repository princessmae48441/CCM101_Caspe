#!/bin/bash
# CloudNova WordPress DB backup (Requirement 4)
# Dumps the MySQL database from the running container, compresses it,
# and deletes backups older than RETENTION_DAYS.
#
# Works from either location:
#   - repo root (next to .env), or
#   - a scripts/ subfolder of the project (e.g. ~/cloudnova-wp/scripts/backup.sh)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/.env" ]; then
  PROJECT_DIR="$SCRIPT_DIR"
else
  PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
fi

BACKUP_DIR="$PROJECT_DIR/backups"
TIMESTAMP=$(date +%F_%H-%M-%S)
RETENTION_DAYS=7

source "$PROJECT_DIR/.env"
mkdir -p "$BACKUP_DIR"

docker exec cloudnova_mysql mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" \
  --single-transaction "$MYSQL_DATABASE" | gzip > "$BACKUP_DIR/wp_db_$TIMESTAMP.sql.gz"

# Remove backups older than the retention period
find "$BACKUP_DIR" -name "wp_db_*.sql.gz" -mtime +"$RETENTION_DAYS" -delete

echo "[$(date)] Backup OK: wp_db_$TIMESTAMP.sql.gz"
