#!/bin/sh
#
# Create and store a base backup.
set -e

name="$1"
remote_name="${RCLONE_REMOTE:-remote}"
config_file="${RCLONE_CONFIG_FILE:-/etc/rclone.conf}"

if [ -z "$name" ]; then
    echo "usage: $0 backup_name"
    exit 1
fi

pg_basebackup \
    --pgdata=- \
    --format=tar \
    --wal-method=none \
    --compress=zstd \
    --checkpoint=fast |
    rclone --config "$config_file" rcat "$remote_name":"$name"
