# S3

# Table of Contents

- [About the Service](#about-the-service)
- [Deployment](#deployment)

# About the Service

[Amazon S3](https://aws.amazon.com/s3/) provides object storage buckets on the AWS cloud. talel.io utilizes three buckets, two public buckets for hosting static web app content and one private bucket for storing data such as database dumps and Terraform state files.

# Deployment

This Terraform module creates the two public buckets used in development and production and configures their policies.

> ⚠️ Buckets needs to be created and public access permissions set with the `aws_s3_bucket_public_access_block` resource before attaching any bucket policies.

1. Comment out the `aws_s3_bucket_policy` resource for `talelio_test_content_policy` and `talelio_user_content_policy`.

2. Run the `terraform plan` command followed by `terraform apply` to create the buckets and set their public access permissions.

3. Uncomment the `aws_s3_bucket_policy` resource for `talelio_test_content_policy` and `talelio_user_content_policy`.

4. Run the `terraform plan` command followed by `terraform apply` to allow public read-only access to the buckets contents.
