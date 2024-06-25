terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = "~> 1.3"
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name} IGW"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = data.aws_availability_zones.available.names[0]
  cidr_block              = var.public_subnet_1_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name} Public Subnet (AZ1)"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = data.aws_availability_zones.available.names[1]
  cidr_block              = var.public_subnet_2_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name} Public Subnet (AZ2)"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = data.aws_availability_zones.available.names[0]
  cidr_block              = var.private_subnet_1_cidr_block
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name} Private Subnet (AZ1)"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = data.aws_availability_zones.available.names[1]
  cidr_block              = var.private_subnet_2_cidr_block
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name} Private Subnet (AZ2)"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name} Public Routes"
  }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table_1" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name} Private Routes (AZ1)"
  }
}

resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table_1.id
}

resource "aws_route_table" "private_route_table_2" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name} Private Routes (AZ2)"
  }
}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table_2.id
}

module "nat_1" {
  source = "RaJiska/fck-nat/aws"

  name               = "${var.name}-fck-nat-az1"
  vpc_id             = aws_vpc.vpc.id
  subnet_id          = aws_subnet.public_subnet_1.id
  update_route_table = true
  route_table_id     = aws_route_table.private_route_table_1.id
}

module "nat_2" {
  source = "RaJiska/fck-nat/aws"

  name               = "${var.name}-fck-nat-az2"
  vpc_id             = aws_vpc.vpc.id
  subnet_id          = aws_subnet.public_subnet_2.id
  update_route_table = true
  route_table_id     = aws_route_table.private_route_table_2.id
}
