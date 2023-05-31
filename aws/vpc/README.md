# AWS VPC

# Table of Contents

- [About the Service](#about-the-service)
    - [Internet Gateway and Route Table](#internet-gateway-and-route-table)
    - [Security Groups](#security-groups)
    - [Elastic IP](#elastic-ip)
- [Deployment](#deployment)

# About the Service

[Amazon VPC](https://aws.amazon.com/vpc/) provides a virtual private cloud on which various AWS services are connected together and can be made accessible to the public internet.

A VPC is placed in a region, e.g. `us-east-1`, and within the VPC are private and/or public subnets which can be placed in different availability zones[^1]. EC2 instances and other compute services are launched on the subnets and these resources can communicate across different availability zones.

For talel.io, a custom VPC is used in a simple setup where one EC2 instance is running on a public subnet. The EC2 instance is exposed to the internet via port 80, 443 and 22 for SSH.

```mermaid
flowchart
    subgraph VPC: 10.0.0.0/16
    subgraph Public Subnet: 10.0.1.0/24
    subgraph EC2 <br/> Ports: 80, 443, 22
    end
    end
    end
```

## Internet Gateway and Route Table

By default a VPC does not allow access from the public internet. To enable public internet access an internet gateway needs to be set up and associated with the VPC.

To manage where traffic goes, a route table with routes defined for the internet gateway also needs to be associated with both the VPC and the public subnets.

For talel.io, the internet gateway and route table is allowing access to and from the public internet for anything running on the talel.io public subnet. Access to the public subnet resources is however secured by the [security group](#security-groups) ingress and egress rules.

## Security Groups

A security group works like a firewall for the resources in the VPC where the ingress (inbound) and egress (outbound) rules controls the traffic to and from a resource.

## Elastic IP

AWS Elastic IP (EIP) provides a fixed public IPv4 address that will stay allocated for as long as the EIP is not deleted[^2]. A EIP is attached to one instance at a time but can be remapped to other instances.

# Deployment

Run the `terraform plan` command followed by `terraform apply` to set up the talel.io VPC with its subnet, internet gateway and route table as well as allocating a public IPv4 address.

[^1]: An availability zone is a data center in a cluster of data centers. Each region contains two or more availability zones.

[^2]: EIP is free of charge when attached to a running instance, if these conditions are not met additional [charges](https://aws.amazon.com/ec2/pricing/on-demand/#Elastic_IP_Addresses) apply.
