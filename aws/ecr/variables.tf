variable "talelio_repositories" {
  type = list(string)
  default = [
    "talelio-postgresql",
    "talelio-backend-api"
  ]
}
