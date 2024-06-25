variable name {
  description = "The environment name."
  type        = string
}

variable region {
  description = "The AWS region to deploy resources."
  default     = "us-east-2"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  default     = "10.192.0.0/16"
  type        = string
}

variable "public_subnet_1_cidr_block" {
  description = "The CIDR block for the public subnet in the first AZ."
  default     = "10.192.10.0/24"
  type        = string
}

variable "public_subnet_2_cidr_block" {
  description = "The CIDR block for the public subnet in the second AZ."
  default     = "10.192.11.0/24"
  type        = string
}

variable "private_subnet_1_cidr_block" {
  description = "The CIDR block for the private subnet in the first AZ."
  default     = "10.192.20.0/24"
  type        = string
}

variable "private_subnet_2_cidr_block" {
  description = "The CIDR block for the private subnet in the second AZ."
  default     = "10.192.21.0/24"
  type        = string
}
