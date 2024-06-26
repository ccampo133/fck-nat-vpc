# fck-nat-vpc

Terraform module to create a VPC with the following resources:

* A VPC.
* One internet gateway.
* Two public subnets (one per AZ) and their route tables.
* Two private subnets (one per AZ) and their route tables.
* Two [fck-nat](https://fck-nat.dev/stable/) instances (one per public subnet)
  as NAT gateways. These are controlled by ASGs.

## Usage

Assuming you have AWS credentials configured (e.g. as environment variables):

```bash
$ terraform init
$ terraform plan -var 'name=fcknat'
$ terraform apply -var 'name=fcknat'
```

See [`variables.tf`](variables.tf) for the list of variables that can be
configured.
