terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
}

# TODO: Parameterize bucket name and key for the below resources

resource "aws_s3_bucket" "talelio_backups" {
  bucket = "talelio-backups"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_object" "postgres_db_backups" {
  bucket       = "talelio-backups"
  key          = "postgres-db-backups"
  content_type = "application/x-directory"
}
