variable name {
  description = "The environment name."
  type        = string
}

variable region {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-2"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.192.0.0/16"
}

variable "public_subnet_1_cidr_block" {
  description = "The CIDR block for the public subnet in the first AZ."
  type        = string
  default     = "10.192.10.0/24"
}

variable "public_subnet_2_cidr_block" {
  description = "The CIDR block for the public subnet in the second AZ."
  type        = string
  default     = "10.192.11.0/24"
}

variable "private_subnet_1_cidr_block" {
  description = "The CIDR block for the private subnet in the first AZ."
  type        = string
  default     = "10.192.20.0/24"
}

variable "private_subnet_2_cidr_block" {
  description = "The CIDR block for the private subnet in the second AZ."
  type        = string
  default     = "10.192.21.0/24"
}

variable nat_instance_type {
  description = "The instance type to use for the NAT instance."
  type        = string
  default     = "t4g.nano"
}

variable use_ssh {
  description = "Whether to allow SSH access to the fck-nat instances."
  type        = bool
  default     = false
}

variable ssh_key_name {
  description = "The name of the SSH key to use for the fck-nat instances."
  type        = string
  default     = ""
}

variable ssh_cidr_blocks {
  description = "The CIDR blocks to allow SSH access from."
  type = object({
    ipv4 = optional(list(string), [])
    ipv6 = optional(list(string), [])
  })
  default = {
    ipv4 = ["0.0.0.0/0"]
    ipv6 = ["::/0"]
  }
}
