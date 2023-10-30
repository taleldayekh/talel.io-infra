#!/bin/sh

S3_URI="s3://${S3_BACKUPS_BUCKET}/${S3_POSTGRES_BACKUPS_PREFIX}"

latest_db_backup=$( \
    aws s3api list-objects \
    --bucket "${S3_BACKUPS_BUCKET}" \
    --prefix "${S3_POSTGRES_BACKUPS_PREFIX}" \
    --query "reverse(sort_by(Contents, $LastModified))[0].Key" \
    --output text \
    | tail -n1 \
    | awk -F/ "{print $NF}")

if [ -z "$latest_db_backup" ]; then
    aws s3 cp "${S3_URI}/${latest_db_backup}" ~
    psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" < "~/${latest_db_backup}"
else
    echo "No database backup file found in S3"
fi
