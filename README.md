# fck-nat-vpc

Terraform module to create a VPC with the following resources:

* A VPC.
* One internet gateway.
* Two public subnets (one per AZ) and their route tables.
* Two private subnets (one per AZ) and their route tables.
* Two [fck-nat](https://fck-nat.dev/stable/) instances (one per public subnet)
  as NAT gateways. These are controlled by ASGs.

## Background

NAT gateways are expensive - [fck-nat](https://fck-nat.dev/stable/) is a good
affordable alternative for small and non-critical workloads, like dev
environments and personal projects.

## Usage

Assuming you have AWS credentials configured (e.g. as environment variables):

```bash
$ terraform init
$ terraform plan -var 'name=fcknat'
$ terraform apply -var 'name=fcknat'
```

See [`variables.tf`](variables.tf) for the list of variables that can be
configured. Also see the
[official fck-nat Terraform module](https://github.com/RaJiska/terraform-aws-fck-nat)
(which is used by this module) for more information.
