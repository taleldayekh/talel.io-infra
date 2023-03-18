module "vpc" {
  source = "../aws/vpc"
}

resource "namecheap_domain_records" "talel-io" {
  domain = "talel.io"
  mode   = "OVERWRITE"

  # Begin GitHub Pages records
  record {
    hostname = "@"
    type     = "A"
    address  = "185.199.108.153"
  }

  record {
    hostname = "@"
    type     = "A"
    address  = "185.199.109.153"
  }

  record {
    hostname = "@"
    type     = "A"
    address  = "185.199.110.153"
  }

  record {
    hostname = "@"
    type     = "A"
    address  = "185.199.111.153"
  }
  # End GitHub pages records

  # Begin talel.io backend API record
  record {
    hostname = "api"
    type     = "A"
    address  = module.vpc.public_elastic_ip
  }
  # End talel.io backend API record
}
