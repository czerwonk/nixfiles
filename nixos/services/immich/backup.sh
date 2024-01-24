set -e

BACKUP_DIR_BASE="/data/backup/immich"
BACKUP_DIR="$BACKUP_DIR_BASE/$(date +%Y-%m-%d)"

mkdir -p $BACKUP_DIR

echo "Backup DB"
podman exec immich_postgres pg_dumpall --user postgres | gzip > $BACKUP_DIR/db.sql.gz

echo "Purge old backups"
find $BACKUP_DIR_BASE -maxdepth 1 -type d -mtime +2 -exec rm -R {} \;
