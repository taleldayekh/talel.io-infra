# AWS VPC

# Table of Contents

- [EIP](#eip-elastic-ip)

## EIP (Elastic IP)

AWS Elastic IP provides a fixed public IPv4 IP address that will stay allocated as long as the EIP is not deleted[^1]. A EIP is attached to one instance at the time but can be remapped to other instances.

The `aws_eip` Terraform resource allocates an EIP in Amazon's pool of IPv4 addresses without associating it with any instance.

[^1]: A EIP is free of charge when attached to a running instance, if these conditions are not met additional [charges](https://aws.amazon.com/ec2/pricing/on-demand/#Elastic_IP_Addresses) apply.
