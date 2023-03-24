variable "postgres_user" {
  type = string
}

variable "postgres_password" {
  type = string
}

variable "postgres_db" {
  type = string
}

variable "aws_access_key_id" {
  type = string
}

variable "aws_secret_access_key" {
  type = string
}

variable "s3_backups_bucket" {
  type = string
}

variable "s3_postgres_backups_prefix" {
  type = string
}
