# AWS ECR

# Table of Contents

- [Dockerfiles](#dockerfiles)
  - [PostgreSQL](#postgresql)
  - [NGINX](#nginx)

# Dockerfiles

## PostgreSQL

## NGINX

Before building and pushing the `nginx` image:

- Update `proxy_pass` in the [`talelio.conf`](https://github.com/taleldayekh/talel.io-infra/blob/bc34b6e915c8dd81a12b33724ec5443d2a38c9c0/aws/ecr/dockerfiles/nginx/talelio.conf#L6) NGINX config with the private IPv4 address of the EC2 instance that will run the container.
- Update the `certbot` command in the [`entrypoint.sh`](https://github.com/taleldayekh/talel.io-infra/blob/bc34b6e915c8dd81a12b33724ec5443d2a38c9c0/aws/ecr/dockerfiles/nginx/entrypoint.sh#L3) script with a valid email address.

<!-- Repositories must exist before the lifecycle policy is added, comment out code and make sure they exists first

When running on ECR the AWS credentials are automatically made available therefore no values need to be passed for them. -->
