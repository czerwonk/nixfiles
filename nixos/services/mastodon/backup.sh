set -e

BACKUP_DIR_BASE="/data/backup/mastodon"
BACKUP_DIR="$BACKUP_DIR_BASE/$(date +%Y-%m-%d)"

mkdir -p $BACKUP_DIR

echo "Backup DB"
podman exec mastodon-db pg_dumpall -U postgres | gzip > $BACKUP_DIR/db.sql.gz

echo "Backup REDIS data"
tar cfz $BACKUP_DIR/redis.tgz /var/lib/containers/storage/volumes/mastodon_redis-data/_data/dump.rdb

echo "Backup files"
tar cfz $BACKUP_DIR/files.tgz /var/lib/containers/storage/volumes/mastodon_system-data/_data/

echo "Purge old backups"
find $BACKUP_DIR_BASE -maxdepth 1 -type d -mtime +2 -exec rm -R {} \;
