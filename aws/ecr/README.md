# AWS ECR

# Table of Contents

- [About the Service](#about-the-service)
- [Deployment Notes](#deployment-notes)
- [Dockerfiles](#dockerfiles)
  - [Postgres](#postgres)
  - [NGINX](#nginx)

# About the Service

# Deployment Notes

**Plan**

```shell
terraform plan -var-file=ecr.tfvars
```

**Apply**

```shell
terraform apply -var-file=ecr.tfvars
```

# Dockerfiles

## Postgres

PostgreSQL container for the talelio database.

When container spins up, the `restore_db.sh` script is executed which checks for and recovers the latest database backup from S3.

A cron job is executing the `backup_db.sh` script nightly for creating database backup dumps to S3.

**Expected build args:**

```shell
PATH_TO_ENTRYPOINT_SCRIPT
PATH_TO_RESTORE_DB_SCRIPT
PATH_TO_BACKUP_DB_SCRIPT
POSTGRES_USER
POSTGRES_PASSWORD
POSTGRES_DB
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
S3_BACKUPS_BUCKET
S3_POSTGRES_BACKUPS_PREFIX
```

## NGINX

**Before pushing the NGINX image:**

- Update `proxy_pass` in the `talelio.conf` NGINX config with the private IPv4 address of the EC2 instance that will be running the container.

- Update the `certbot` command in the `entrypoint.sh` script with a valid email address.
