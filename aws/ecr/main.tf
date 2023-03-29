resource "aws_ecr_repository" "talelio_postgresql" {
  name = "talelio-postgresql"
}

resource "docker_image" "talelio_postgresql" {
  name = "${aws_ecr_repository.talelio_postgresql.repository_url}:latest"

  build {
    context    = "${path.root}/postgresql"
    dockerfile = "Dockerfile"
    no_cache   = true

    platform = "linux/amd64"

    build_args = {
      RESTORE_DB_SCRIPT          = "${path.root}/restore_postgres_db.sh"
      POSTGRES_USER              = var.postgres_user
      POSTGRES_PASSWORD          = var.postgres_password
      POSTGRES_DB                = var.postgres_db
      AWS_ACCESS_KEY_ID          = var.aws_access_key_id
      AWS_SECRET_ACCESS_KEY      = var.aws_secret_access_key
      S3_BACKUPS_BUCKET          = var.s3_backups_bucket
      S3_POSTGRES_BACKUPS_PREFIX = var.s3_postgres_backups_prefix
    }
  }
}

resource "docker_registry_image" "talelio_postgresql" {
  name = docker_image.talelio_postgresql.name
}
