# AWS VPC

# Table of Contents

- [About the Service](#about-the-service)
- [Custom VPC](#custom-vpc)
    - [Subnet](#subnet)
    - [CIDR Blocks](#cidr-blocks)
- [Security Groups](#security-groups)
- [Elastic IP](#elastic-ip)

# About the Service

[Amazon VPC](https://aws.amazon.com/vpc/) is a virtual private cloud in which various services are connected together and can be made accessible to the public internet.

A VPC is placed in a region, e.g. `us-east-1`, and within the VPC are private and/or public subnets which can be placed in different availability zones[^1].

EC2 instances and other compute services are launched on the subnets and these resources can communicate across different availability zones.

# Custom VPC

A custom VPC is used for talel.io in a simple setup where one EC2 instance is running on a public subnet. The public subnet is exposed to the internet via port 80, 443 and 22.

```mermaid
flowchart
    subgraph VPC VPC / 10.0.0.0/16
    subgraph Public Subnet / 10.0.1.0/24
    subgraph EC2
    end
    end
    end
```

## Subnet

## CIDR Blocks

# Security Groups

# Elastic IP

AWS Elastic IP (EIP) provides a fixed public IPv4 IP address that will stay allocated as long as the EIP is not deleted[^2]. A EIP is attached to one instance at a time but can be remapped to other instances.

> ⚠️ The `aws_eip` Terraform resource is allocating an EIP in Amazon's pool of IPv4 addresses without associating it with any instance.

[^1]: A availability zone is a data center in a cluster of data centers. Each region contains two or more availability zones.

[^2]: EIP is free of charge when attached to a running instance, if these conditions are not met additional [charges](https://aws.amazon.com/ec2/pricing/on-demand/#Elastic_IP_Addresses) apply.
