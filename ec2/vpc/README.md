# Caprica VPC

Caprica is the name of the VPC positioned within AWS and is the default VPC for instances deployed in AWS US East 1.

It provides ingress and egress by default, with security groups providing the basic connection security.

The VPC is enabled for IPv6 with all subnets enabled to receive an IPv6 IP address.  All subnets also are aligned to a Network Access Control List, which has been curated over the many years that mikesoh.com has been available.

The inclusion of the CloudFormation template is so that logging can be done on a per-commit basis.

