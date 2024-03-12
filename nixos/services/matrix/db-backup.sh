set -eo pipefail

BACKUP_DIR="/data/backup/matrix"

mkdir -p $BACKUP_DIR

echo "Backup DB"
podman exec matrix-db pg_dumpall --user synapse | gzip > $BACKUP_DIR/db.sql.gz.tmp
mv $BACKUP_DIR/db.sql.gz.tmp $BACKUP_DIR/db.sql.gz
