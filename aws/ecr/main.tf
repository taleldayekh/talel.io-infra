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
                "description": "Keep latest image only",
                "selection": {
                    "tagStatus": "any",
                    "countType": "imageCountMoreThan",
                    "countNumber": 1,
                    "countUnit": "image"
                },
                "action": {
                    "type": "expire"
                }
            }
        ]
    }
    EOF
}

resource "docker_image" "talelio_postgresql" {}
