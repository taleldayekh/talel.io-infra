terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "talelio-backups"
    key    = "terraform-states/ecr/terraform.tfstate"
  }
}
