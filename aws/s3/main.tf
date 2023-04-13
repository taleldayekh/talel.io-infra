resource "aws_s3_bucket_object" "upload_postgresql_backup_script" {
    bucket = ""
    key = "backup-postgresql-db.sh"
    source = "backup-postgresql-db.sh"
}
