FROM postgres:16-alpine

# Pass path to scripts as build args so this
# Dockerfile finds them in its build context.
ARG PATH_TO_ENTRYPOINT_SCRIPT
ARG PATH_TO_RESTORE_DB_SCRIPT
ARG PATH_TO_BACKUP_DB_SCRIPT

ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG POSTGRES_DB

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

ARG S3_BACKUPS_BUCKET
ARG S3_POSTGRES_BACKUPS_PREFIX

ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
ENV POSTGRES_DB=${POSTGRES_DB}

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

ENV S3_BACKUPS_BUCKET=${S3_BACKUPS_BUCKET}
ENV S3_POSTGRES_BACKUPS_PREFIX=${S3_POSTGRES_BACKUPS_PREFIX}

COPY ${PATH_TO_ENTRYPOINT_SCRIPT} /usr/local/bin/entrypoint.sh
# ! Must be placed here to run SQL scripts
COPY ${PATH_TO_RESTORE_DB_SCRIPT} /docker-entrypoint-initdb.d/
COPY ${PATH_TO_BACKUP_DB_SCRIPT} /usr/local/bin/backup_db.sh

RUN apk add --no-cache aws-cli
RUN apk add --no-cache busybox

RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /docker-entrypoint-initdb.d/restore_postgres_db.sh
RUN chmod +x /usr/local/bin/backup_db.sh

# Create cron job for daily database backups
RUN echo '0 3 * * * /usr/local/bin/backup_db.sh' > /etc/crontabs/root

EXPOSE 5234

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
