#!/usr/bin/env sh

latest_db_backup_filename=$( \
aws s3api list-objects \
--bucket $S3_BACKUPS_BUCKET \
--prefix $S3_POSTGRES_BACKUPS_PREFIX \
--query 'reverse(sort_by(Contents, &LastModified))[0].Key' \
--output text \
| tail -n1 \
| awk -F/ '{print $NF}')

aws s3 cp s3://$S3_BACKUPS_BUCKET/$S3_POSTGRES_BACKUPS_PREFIX/$latest_db_backup_filename ~

psql -U $POSTGRES_USER -d $POSTGRES_DB < ~/$latest_db_backup_filename
