terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {
  registry_auth {
    address  = "${data.aws_caller_identity.aws_identity.account_id}.dkr.ect.us-east-1.amazonaws.com"
    username = data.aws_ecr_authorization_token.aws_token.user_name
    password = data.aws_ecr_authorization_token.aws_token.password
  }
}
