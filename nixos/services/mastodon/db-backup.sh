set -eo pipefail

BACKUP_DIR="/data/backup/mastodon"

mkdir -p $BACKUP_DIR

echo "Backup DB"
podman exec mastodon-db pg_dumpall -U postgres | gzip > $BACKUP_DIR/db.sql.gz.tmp
mv $BACKUP_DIR/db.sql.gz.tmp $BACKUP_DIR/db.sql.gz
