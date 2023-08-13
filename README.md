# PostgreSQL with Rclone

A container image for a PostgreSQL server that archives WAL logs using Rclone.

## Usage

Set the following environment variables:

- `RCLONE_CONFIG_FILE` - The path to the Rclone config inside the container. Should be
  readable by UID/GID 70. Defaults to `/etc/rclone.conf`.
- `RCLONE_REMOTE` - The name of the Rclone remote files are saved to. Defaults to
  `remote`.

You can create a base backup by running `/usr/local/bin/basebackup.sh` inside the
container.

Files are compressed with zstd before uploading.
