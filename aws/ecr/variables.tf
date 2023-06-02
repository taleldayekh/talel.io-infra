variable "talelio_repositories" {
  type = list(string)
  default = [
    "talelio-backend-api",
    "talelio-postgresql",
    "talelio-redis",
    "talelio-nginx"
  ]
}
