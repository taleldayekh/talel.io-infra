# Namecheap

# Table of Contents

- [Deployment](#deployment)
- [Namecheap API Access](#namecheap-api-access)
    - [Enable API Access](#enable-api-access)
    - [Whitelist IP](#whitelist-ip)

# Deployment

Before running the `terraform plan` and/or the `terraform apply` commands, ensure that the environment variables listed below are defined in a `namecheap.tfvars` file.

| Key                 | Value                           |
|---------------------|---------------------------------|
| namecheap_user_name | \<namecheap account user name\> |
| namecheap_api_user  | \<namecheap account user name\> |
| namecheap_api_key   | \<alloted api key\>             |

## Plan

```shell
terraform plan -var-file=namecheap.tfvars
```

## Apply

```shell
terraform apply -var-file=namecheap.tfvars
```

# Namecheap API Access

Namecheap API access needs to be enabled before configuring domain records with Terraform is possible.

API access is granted by Namecheap if the prerequisites listed in this [article](https://www.namecheap.com/support/knowledgebase/article.aspx/10502/2208/namecheap-terraform-provider/) are met.

## Enable API Access

API access can be toggled on in the Namecheap account by navigating to: `Profile --> Tools --> Namecheap API Access`.

Toggling on API access will generate an API key.

## Whitelist IP
