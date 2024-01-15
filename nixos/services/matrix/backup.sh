set -e

BACKUP_DIR_BASE="/data/backup/matrix"
BACKUP_DIR="$BACKUP_DIR_BASE/$(date +%Y-%m-%d)"

mkdir -p $BACKUP_DIR

echo "Backup files"
tar cfz $BACKUP_DIR/files.tgz /opt/matrix

echo "Backup DB"
pushd /opt/matrix
podman-compose exec -u postgres db pg_dumpall --user synapse | gzip > $BACKUP_DIR/db.sql.gz
popd

echo "Purge old backups"
find $BACKUP_DIR_BASE -maxdepth 1 -type d -mtime +2 -exec rm -R {} \;
