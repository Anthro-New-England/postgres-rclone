ARG POSTGRES_VERSION=alpine
FROM postgres:${POSTGRES_VERSION}
RUN apk add zstd rclone
COPY archive.sh restore.sh basebackup.sh /usr/local/bin/
RUN chmod 0755 \
    /usr/local/bin/archive.sh \
    /usr/local/bin/basebackup.sh \
    /usr/local/bin/restore.sh
RUN echo "" > /etc/rclone.conf \
    && chown postgres:postgres /etc/rclone.conf \
    && chmod u=rw,g=,o= /etc/rclone.conf
COPY postgresql.conf /usr/local/share/postgresql/postgresql.conf.sample
RUN chmod 0644 /usr/local/share/postgresql/postgresql.conf.sample
ENV RCLONE_REMOTE=remote
ENV RCLONE_CONFIG_FILE=/etc/rclone.conf
