terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

module "ecr" {
  source = "./ecr"
}

provider "aws" {
  region                  = var.aws_region
  shared_credentials_file = "~/.aws/credentials"
}

provider "docker" {
  registry_auth {
    address  = "${module.ecr.aws_identity.account_id}.dkr.ect.${var.aws_region}.amazonaws.com"
    username = module.ecr.aws_token.user_name
    password = module.ecr.aws_token.password
  }
}
