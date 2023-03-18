# Namecheap

# Table of Contents

- [Deployment](#deployment)

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
