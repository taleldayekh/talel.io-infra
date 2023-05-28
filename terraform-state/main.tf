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

resource "aws_s3_bucket" "talelio_backups" {
  bucket = "talelio-backups"

  lifecycle {
    prevent_destroy = true
  }
}
