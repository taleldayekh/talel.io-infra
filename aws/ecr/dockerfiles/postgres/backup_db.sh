#!/bin/sh

TIMESTAMP=$(date "+%y%m%d-%H%M%S")
BACKUP_DIR="talelio-db-backup"
BACKUP_FILE="${BACKUP_DIR}-${TIMESTAMP}.sql"
BACKUP_LOGS="$HOME/${BACKUP_DIR}/${BACKUP_DIR}.log"
S3_URI="s3://${S3_BACKUPS_BUCKET}/${S3_POSTGRES_BACKUPS_PREFIX}/"

# Create directory for temporarily storing
# the db backup file for upload to S3.
if ! [ -d "$HOME/${BACKUP_DIR}" ]; then
    echo "Creating backup directory"
    mkdir -p "$HOME/${BACKUP_DIR}"
    touch "${BACKUP_LOGS}"
fi

echo "Creating ${BACKUP_FILE}" >> "${BACKUP_LOGS}"
pg_dump -c -U "${POSTGRES_USER}" "${POSTGRES_DB}" > "$HOME/${BACKUP_DIR}/${BACKUP_FILE}"

if [ -f "$HOME/${BACKUP_DIR}/${BACKUP_FILE}" ]; then
    echo "Uploading ${BACKUP_FILE} to S3" >> "${BACKUP_LOGS}"

    # Upload db backup file to S3 and check if it exists
    aws s3 cp "$HOME/${BACKUP_DIR}/${BACKUP_FILE}" "${S3_URI}"
    aws s3api head-object --bucket "${S3_BACKUPS_BUCKET}" --key "${S3_POSTGRES_BACKUPS_PREFIX}/${BACKUP_FILE}" || backup_failed=true

    if [ $backup_failed ]; then
        echo "S3 upload failed"
    else
        echo "Deleting database backup from container"
        rm "$HOME/${BACKUP_DIR}/${BACKUP_FILE}"
    fi
fi
