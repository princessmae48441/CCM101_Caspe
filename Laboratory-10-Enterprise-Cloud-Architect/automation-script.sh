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

