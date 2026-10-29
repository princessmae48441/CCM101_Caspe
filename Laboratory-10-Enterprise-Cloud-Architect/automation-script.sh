
## Database Backup Automation

The CloudNova backup script creates a compressed backup of the WordPress MySQL database, verifies the compressed file, and removes backups older than seven days.

### Backup Script

```bash
#!/usr/bin/env bash
# CloudNova WordPress database backup
set -Eeuo pipefail
umask 077

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$SCRIPT_DIR"
BACKUP_DIR="$PROJECT_DIR/backups"
TIMESTAMP="$(date +%F_%H-%M-%S)"
RETENTION_DAYS=7
CONTAINER_NAME="cloudnova_mysql"

if [[ ! -f "$PROJECT_DIR/.env" ]]; then
  echo "ERROR: Missing $PROJECT_DIR/.env; copy .env.example to .env and configure it." >&2
  exit 1
fi

# Load local configuration. Keep .env private and never commit it.
set -a
# shellcheck disable=SC1091
source "$PROJECT_DIR/.env"
set +a

: "${MYSQL_ROOT_PASSWORD:?MYSQL_ROOT_PASSWORD is not set in .env}"
: "${MYSQL_DATABASE:=wordpress}"

mkdir -p "$BACKUP_DIR"
BACKUP_FILE="$BACKUP_DIR/wp_db_${TIMESTAMP}.sql.gz"
TMP_FILE="${BACKUP_FILE}.tmp"

cleanup() {
  rm -f "$TMP_FILE"
}
trap cleanup EXIT

if ! docker inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
  echo "ERROR: Container $CONTAINER_NAME was not found. Is the stack running?" >&2
  exit 1
fi

docker exec "$CONTAINER_NAME" sh -c \
  'exec mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" --single-transaction "$MYSQL_DATABASE"' \
  | gzip -c > "$TMP_FILE"

gzip -t "$TMP_FILE"
mv "$TMP_FILE" "$BACKUP_FILE"

find "$BACKUP_DIR" -maxdepth 1 -type f -name 'wp_db_*.sql.gz' -mtime +"$RETENTION_DAYS" -delete

echo "[$(date --iso-8601=seconds)] Backup OK: $(basename "$BACKUP_FILE")"
```

### How to Run the Backup

Run the following command on the Ubuntu Server VM:

```bash
./scripts/backup.sh
```

### Verify the Backup

List the generated backup files:

```bash
ls -lh backups/
```

Verify a backup archive, replacing the filename with the actual file:

```bash
gzip -t backups/wp_db_YYYY-MM-DD_HH-MM-SS.sql.gz
```

If the command finishes without an error, the compressed archive passed the integrity check.

### Security Notes

- Keep `.env` private and exclude it from GitHub using `.gitignore`.
- Never commit real passwords or database backup files.
- Store backup copies outside the VM for better recovery protection.
- Test database restoration separately; a successful compression check does not prove that a database can be restored.
