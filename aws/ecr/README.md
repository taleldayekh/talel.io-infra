# AWS ECR

# Table of Contents

- [About the Service](#about-the-service)
- [Deployment](#deployment)
- [Dockerfiles](#dockerfiles)
    - [PostgreSQL](#postgresql)

# About the Service

[Amazon ECR](https://aws.amazon.com/ecr/) are Docker image repositories on AWS. Each image has its separate repository with different versions of a given image.

# Deployment

Before running the `terraform plan` and/or `terraform apply` commands, ensure that the environment variables listed below are defined in a `ecr.tfvars` file.

| Key                        | Value                                                        |
|----------------------------|--------------------------------------------------------------|
| postgres_user              | \<talel.io postgres user\>                                   |
| postgres_password          | \<talel.io postgres password\>                               |
| postgres_db                | \<talel.io postgres db\>                                     |
| aws_access_key_id          | \<access key id for user with talel.io aws permissions\>     |
| aws_secret_access_key      | \<secret access key for user with talel.io aws permissions\> |
| s3_backups_bucket          | \<s3 backups bucket name\>                                   |
| s3_postgres_backups_prefix | \<s3 postgres backups subfolder name\>                       |

## Plan

```shell
terraform plan -var-file=ecr.tfvars
```

## Apply

Docker needs to be running locally for applying changes that requires building images.

```shell
terraform apply -var-file=ecr.tfvars
```

# Dockerfiles

## PostgreSQL

The PostgreSQL Dockerfile runs a Dockerized PostgreSQL database with the credentials for talel.io.

When the container is started the `restore_postgres_db.sh` script retrieves the latest database backup from AWS S3 and restores the data. This ensures that whenever the container is stopped and restarted the database will always contain the latest data.

> ⚠️ The Dockerfile installs AWS CLI v1 for retrieving the database backup from S3. Currently AWS CLI v2 is not available via `apk` for Alpine Linux.
