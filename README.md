# fck-nat-vpc

Terraform module to create a VPC with the following resources:

* A VPC.
* One internet gateway.
* Two public subnets (one per AZ).
* Two private subnets (one per AZ).
* Two [fck-nat](https://fck-nat.dev/stable/) instances (one per public subnet)
  as NAT gateways.

## Usage

Assuming you have AWS credentials configured (e.g. as environment variables):

```bash
$ terraform init
$ terraform plan -var 'name=fcknat'
$ terraform apply -var 'name=fcknat'
```

See [`variables.tf`](variables.tf) for the list of variables that can be
configured.
