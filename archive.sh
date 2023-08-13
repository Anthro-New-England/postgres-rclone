#!/bin/sh
#
# Archive a WAL file.
set -e

path="$1"
fn="$2"
remote_name="${RCLONE_REMOTE:-remote}"
config_file="${RCLONE_CONFIG_FILE:-/etc/rclone.conf}"

if [ ! -f "$path" ]; then
    echo "file not found: $path"
    exit 1
fi

if [ -z "$fn" ]; then
    echo "usage: $0 file_path file_name"
    exit 1
fi

zstd <"$path" -9 |
    rclone --config "$config_file" rcat "$remote_name":"$fn"
