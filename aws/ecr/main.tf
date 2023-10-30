# Create ECR repositories and define lifecycle policies
resource "aws_ecr_repository" "talelio_repositories" {
  for_each = toset(var.talelio_repositories)
  name     = each.value
}

resource "aws_ecr_lifecycle_policy" "talelio_repository_lifecycle" {
  for_each   = toset(var.talelio_repositories)
  repository = each.key

  policy = <<EOF
    {
        "rules": [
            {
                "rulePriority": 1,
                "description": "Keep latest two images only",
                "selection": {
                    "tagStatus": "any",
                    "countType": "imageCountMoreThan",
                    "countNumber": 2
                },
                "action": {
                    "type": "expire"
                }
            }
        ]
    }
    EOF
}

# Upload Docker images to repositories
resource "docker_image" "talelio_postgresql" {
  name = "talelio-postgresql"

  build {
    context    = "${path.root}/dockerfiles/postgres"
    dockerfile = "Dockerfile"
    no_cache   = true
    platform   = "linux/amd64"

    build_args = {
      PATH_TO_ENTRYPOINT_SCRIPT  = "${path.root}/entrypoint.sh"
      PATH_TO_RESTORE_DB_SCRIPT  = "${path.root}/restore_db.sh"
      PATH_TO_BACKUP_DB_SCRIPT   = "${path.root}/backup_db.sh"
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
