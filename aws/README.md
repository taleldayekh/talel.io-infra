# AWS

## Initialize AWS Provider

The AWS Provider must be configured and initialized before any of the AWS services can be deployed using Terraform.

1. Ensure that a AWS `credentials` file is present in the `~/.aws` directory and includes:

   - `aws_access_key_id`
   - `aws_secret_access_key`

2. Ensure that a AWS `config` file is present in the `~/.aws` directory with a default region.

3. Run the `terraform init` command.
