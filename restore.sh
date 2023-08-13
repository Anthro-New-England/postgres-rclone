#!/bin/sh
#
# Restore a WAL file.
set -e

fn="$1"
path="$2"
remote_name="${RCLONE_REMOTE:-remote}"
config_file="${RCLONE_CONFIG_FILE:-/etc/rclone.conf}"

if [ -z "$fn" ]; then
    echo "usage: $0 file_name dest_path"
    exit 1
fi

rclone --config "$config_file" cat "$remote_name":"$fn" |
    unzstd >"$path"
