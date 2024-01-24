set -e

BACKUP_DIR_BASE="/data/backup/matrix"
BACKUP_DIR="$BACKUP_DIR_BASE/$(date +%Y-%m-%d)"

mkdir -p $BACKUP_DIR

echo "Backup files"
tar cfz $BACKUP_DIR/files.tgz /var/lib/containers/storage/volumes/matrix_homeserver_data/_data \
  /var/lib/containers/storage/volumes/matrix_whatsapp_data/_data

echo "Backup DB"
podman exec matrix-db pg_dumpall --user synapse | gzip > $BACKUP_DIR/db.sql.gz

echo "Purge old backups"
find $BACKUP_DIR_BASE -maxdepth 1 -type d -mtime +2 -exec rm -R {} \;
