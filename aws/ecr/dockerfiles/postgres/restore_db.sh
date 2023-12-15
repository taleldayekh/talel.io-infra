#!/bin/sh

latest_db_backup_file=$(
    aws s3api list-objects \
    --bucket "${S3_BACKUPS_BUCKET}" \
    --prefix "${S3_POSTGRES_BACKUPS_PREFIX}" \
    --query "reverse(sort_by(Contents, &LastModified))[0].Key" \
    --output text \
    | tail -n1 \
    | awk -F/ '{print $NF}'
)

if [ -n "$latest_db_backup_file" ]; then
    echo "Database backup file found in S3"
    aws s3 cp "s3://${S3_BACKUPS_BUCKET}/${S3_POSTGRES_BACKUPS_PREFIX}/${latest_db_backup_file}" "$HOME"

    echo "Restoring database from backup file"
    psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" < "$HOME/${latest_db_backup_file}"
else
    echo "No database backup file found in S3"
fi
