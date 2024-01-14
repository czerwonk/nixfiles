set -e

BACKUP_DIR="/data/backup/matrix/$(date +%Y-%m-%d)"
mkdir -p $BACKUP_DIR

echo "Backup files"
tar cfz $BACKUP_DIR/files.tgz /opt/matrix

echo "Backup DB"
pushd /opt/matrix
podman-compose exec -u postgres db pg_dumpall --user synapse | gzip > $BACKUP_DIR/db.sql.gz
popd
